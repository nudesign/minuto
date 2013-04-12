# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.find_or_initialize_by(email: 'suporte@nudesign.com.br')
admin.password = 'f8ks256'
admin.password_confirmation = 'f8ks256'
puts "User #{admin.email} created." if admin.save

admin = User.find_or_initialize_by(email: 'mariana@newcreators.art.br')
admin.password = 'marian@nc2013'
admin.password_confirmation = 'marian@nc2013'
puts "User #{admin.email} created." if admin.save

admin = User.find_or_initialize_by(email: 'amanda@newcreators.art.br')
admin.password = 'amand@nc2013'
admin.password_confirmation = 'amand@nc2013'
puts "User #{admin.email} created." if admin.save

admin = User.find_or_initialize_by(email: 'flavia@newcreators.art.br')
admin.password = 'flavi@nc2013'
admin.password_confirmation = 'flavi@nc2013'
puts "User #{admin.email} created." if admin.save
