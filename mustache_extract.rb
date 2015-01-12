#/usr/bin/env ruby
require "pry"
require "mustache"
require "active_support/all"

file = File.readlines("schema.rb")
no_ends = file[15..-2].select{|x| !x.start_with?("  end") }

groups = no_ends.join.split("create_table").map{|x| x.split("\n") }

arrays = groups.map{|x|
 x.map{|x| x.scan(/"([^"]*)"/) }
  .map{|x| x.first }
  .compact
  .flatten
}.compact.reject { |element| element.empty? }


class BaseModel < Mustache
  def initialize(array)
    @array = array
  end

  def model_name
    @array.first.singularize
  end

  def model_plural
    @array.first.pluralize
  end

  def model_title
    @array.first.singularize.titleize
  end

  def fields
    @array[1..-1].map do |val|
      { field: val }
    end
  end
end

class Index < BaseModel; end
class Form < BaseModel; end
class Show < BaseModel; end
class Controller < BaseModel; end
class Model < BaseModel; end

arrays.each do |arr|
  puts Form.new(arr).render
  puts ""
  puts "-------------------------------------------------"
  puts ""
  puts Index.new(arr).render
  puts ""
  puts "-------------------------------------------------"
  puts ""
  puts Show.new(arr).render
  puts ""
  puts "-------------------------------------------------"
  puts ""
  puts Controller.new(arr).render
  puts ""
  puts "-------------------------------------------------"
  puts ""
  puts Model.new(arr).render
  puts ""
  puts "================================================="
  puts ""
end

test = Index.new(arrays.first).render

def save(file_name, input)
  File.open(file_name, 'w') {|f| f.write(input) }
end

#binding.pry
puts ""
