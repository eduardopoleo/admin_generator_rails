#/usr/bin/env ruby
require "pry"
require "mustache"
require "active_support/all"

file    = File.readlines("schema.rb")
no_ends = file[15..-2].select{|x| !x.start_with?("  end") }           # Filter out junk
groups  = no_ends.join.split("create_table").map{|x| x.split("\n") }  # Bust it into table groups

@@arrays = groups.map do |group|
  group.map{|line| line.scan(/"([^"]*)"/) }  # Grab text in quotes
       .map{|line| line.first }              # create_table row has two elements
       .compact
       .flatten
end.compact.reject { |element| element.empty? }   # Haven't figured out why
                                                  # I'm getting empty arrays here yet

class BaseModel < Mustache
  self.template_path = "./templates"

  def initialize(array)
    @fields = array[1..-1]
    @model_name = array.first
  end

  def model_name
    @model_name.singularize
  end

  def model_plural
    @model_name.pluralize
  end

  def model_title
    @model_name.singularize.titleize.split(" ").join
  end

  def controller_title
    @model_name.pluralize.titleize.split(" ").join
  end

  def fields
    @fields.map do |val|
      { field: val }
    end
  end
end

class Index      < BaseModel; end
class Form       < BaseModel; end
class Show       < BaseModel; end
class Model      < BaseModel; end
class Controller < BaseModel; end

def save(file_name, input)
  File.open(file_name, 'w') {|f| f.write(input) }
end

def generate_templates
  Dir.mkdir("app/controllers/admin")
  Dir.mkdir("app/views/admin")

  @@arrays.each do |arr|
    name = arr.first 
    
    Dir.mkdir("app/views/admin/#{name}")
    form       = Form.new(arr).render
    index      = Index.new(arr).render
    show       = Show.new(arr).render
    controller = Controller.new(arr).render
    model      = Model.new(arr).render

    save("app/views/admin/#{name}/form.haml", form)
    save("app/views/admin/#{name}/index.haml", index)
    save("app/views/admin/#{name}/show.haml", show)
    save("app/controllers/admin/#{name}_controller.rb", controller)
    save("app/models/#{name}.rb", model)
  end

  system("tree")
end

def nd(char) # Nice divider
  puts ""; print char * 80; puts ""; puts ""
end

def test_print
  @@arrays.each do |arr|
    puts Controller.new(arr).render
    nd("-")
    puts Model.new(arr).render
    nd("-")
    puts Form.new(arr).render
    nd("-")
    puts Index.new(arr).render
    nd("-")
    puts Show.new(arr).render
    nd("=")
  end
  nil
end

binding.pry
puts ""
