# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

adopter = Adopter.new(email: "adopter@pph.com", password: "Topsecr3t")
adopter.confirm
adopter.save

RescuerAdmin.create(email: "ra1@pph.com", password: "Topsecr3t")
RescuerAdmin.create(email: "ra2@pph.com", password: "Topsecr3t")
