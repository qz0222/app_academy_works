# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Cat.destroy_all
#ActiveRecord::Base.connection.reset_pk_sequence!(cats)

Cat.create!(
 name: 'Bubbles',
 birth_date: "2014/05/10",
 sex: 'M',
 color: 'black',
 description: 'Bubbles is a bubbly black cat'
)

Cat.create!(
 name: 'Giggles',
 birth_date: "2015/01/17",
 sex: 'F',
 color: 'purple',
 description: 'Giggles a purple cat with wings'
)
