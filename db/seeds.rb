# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Company.create!(name:'Prueba1', rfc:'Prueba1', email:'prueba1@mail.mx', phone:'5510101010', city:'CDMX', number_ext:'1', number_int:'2', postal_code:'03100', state:'CDMX', suburb:'CDMX', address:'CDMX')
User.create!(name: 'Victor', paternal: 'Urquides', maternal: 'Puentes', email: 'vh.urquides@gmail.com', phone: '5520840226', role: 'admin', password: 'Hola2812$', companies_id: Company.last.id)
User.create!(name: 'Prueba2', paternal: 'Prueba2', maternal: 'Prueba2', email: 'prueba2@gmail.com', phone: '5510101010', role: 'employee', password: '123456', companies_id: Company.last.id)
Company.create!(name:'Prueba2', rfc:'Prueba2', email:'prueba2@mail.mx', phone:'5520202020', city:'CDMX', number_ext:'1', number_int:'2', postal_code:'03100', state:'CDMX', suburb:'CDMX', address:'CDMX')