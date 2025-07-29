TOP link: https://www.theodinproject.com/lessons/ruby-on-rails-flight-booker


1. App Goals: 
    - to book a one way flight

2. Lesson Goals: 
    - populating 
    - building drop down menus
    - radio buttons
    - nested submissions
    - seed database

3. Buidling app: 
Step 1: Plan out models and associations
Step 2: Prepare git repository
    - clone into desire folder
    - edit read me (commit 1)
Step 3: Building the Models
    - generate models: Airport, Flight, Booking, Passengers
        - Error: Migrated all models at once instead of migrating after each model generation
            - Cause: In db/migrate/create_flights.rb, foreign_key: true was used for departure_airport and arrival_airport references, but these both point to the same airports table.
                - Lesson learned: Migrate step-by-step after each model generation to catch and fix migration details early. (commit 2)
    - Asssociation: setting
        - Learned: inverse_of: it tells rails that two associations point to the same object in memory, so when you change one, change the other too, no need to reupload to the database.
        - Error: missing moddel class DepartureAirpot
            - Cause: did not create proper association in flight.rb, missed class_name: "Airport"
            - added inverse of to flights, and airport
                - Lesson Learned: always double check associations and that models match
        -Error: same naming convention error
            - Cause: misspelling typo.
            - Lesson Learned: type slow and double check 
        -Tested association via console: 
            airport = Airport.create(code: "SFO")
            arrival = Airport.create(code: "LAX")
            flight = Flight.create(departure_airport: airport, arrival_airport: arrival, start_datetime: DateTime.now)
            booking = Booking.create(flight: flight)                passenger = Passenger.create(name: "Jane Doe", email: "jane@example.com", booking: booking)

            puts flight.departure_airport.code  # => "SFO"
            puts flight.arrival_airport.code    # => "LAX"
            puts booking.passengers.first.name  # => "Jane Doe"
        (commit 3)
    - Seeding the needed information:
        - airport codes
        - flight times
        - booking & passengers
        -learned: Seeding creates consistent, reusable data for development.
            Instead of writing data manualling in the Rails console, Rails gives a dedicated file: db/seeds.rb for defining what data is needed during set up.
            - needs gem "Faker": to generate realistic future datetimes for flights
        (commit 4)
    - Creating Controller: Flight
        - added controller index
        - set routes
        - tested
        (commit 5)
    - Creating Bookings and Confirmations:
        - Error: I wanted there to be a flash message or notice, when no flight was found. However, it would no show despire adding flash notices in multiple places.
            - cause: i did not know if it was passing through or it did not have the proper display logic. what helped to display was rails logger
       - due to random generation, i created a fixed seed flight to test booking and confirmation.
