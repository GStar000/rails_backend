# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# require 'csv'

Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

Spree::OptionCase.create({"name" => "Selection"})
Spree::OptionCase.create({"name" => "Text"})
Spree::OptionCase.create({"name" => "FileUpLoad"})
Spree::OptionCase.create({"name" => "Checkbox"})
Spree::OptionCase.create({"name" => "TextArea"})
