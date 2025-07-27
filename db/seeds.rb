# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Airport.destroy_all
Flight.destroy_all

codes = [ "JFK", "LAX", "ORD", "ATL", "SFO" ]
airports = codes.map { |code| Airport.create!(code: code) }

20.times do
  departure, arrival = airports.sample(2)
  while departure == arrival
    departure, arrival = airports.sample(2)
  end
    Flight.create!(
    departure_airport: departure,
    arrival_airport: arrival,
    start_datetime: Faker::Time.forward(days: 30, period: :morning)
  )
end

puts "Seeded #{Airport.count} airports and #{Flight.count} flights!"

puts "Creating bookings and passengers..."

5.times do
  flight = Flight.all.sample
  booking = Booking.create!(flight: flight)

  rand(1..3).times do
    Passenger.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      booking: booking
    )
  end
end

puts "Seeding complete!"
