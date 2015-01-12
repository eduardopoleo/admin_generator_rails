#/usr/bin/env ruby
require "pry"
require "erb"
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


hashes = arrays.map{|array| {array.first.singularize.to_sym => array[1..-1] } }

hash = hashes.first

template = "
= simple_form_for(@<%= model %>) do |f|
  = f.error_notification

  .form-inputs
  <% rows.each do |row| -%>
  = f.input :<%= row %>
  <% end -%>

  .form-actions
    = f.button :submit
"

hashes.each do |hash|
  model = hash.keys.first.to_s
  rows = hash.values.first

  renderer = ERB.new(template, nil, "-")
  page = renderer.result(binding)
end

binding.pry
puts ""
