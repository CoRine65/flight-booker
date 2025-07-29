require 'faker'
ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF")
Flight.destroy_all
Airport.destroy_all
ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = ON")

airports = {
  "JFK" => Airport.create!(code: "JFK"),
  "LAX" => Airport.create!(code: "LAX"),
  "SFO" => Airport.create!(code: "SFO"),
  "ORD" => Airport.create!(code: "ORD"),
  "SEA" => Airport.create!(code: "SEA")
}

Flight.create!(
  departure_airport: airports["LAX"],
  arrival_airport: airports["SFO"],
  start_datetime: DateTime.new(2025, 7, 29, 14, 0, 0),
)

20.times do
  departure, arrival = airports.values.sample(2)
  while departure == arrival
    departure, arrival = airports.values.sample(2)
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

airports.each do |code, airport|
  puts "#{code} => #{airport.id}"
end
