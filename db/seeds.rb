# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(email: 'tarungarg402@gmail.com', password: 'password', password_confirmation: 'password', tenant_attributes: { domain: 'me' })

u.add_role :me

# u1=User.create(email: 't.garg28@gmail.com', password: 'password', password_confirmation: 'password', tenant_attributes: {domain: 'tarun'})
