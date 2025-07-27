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
        - First error: Migrated all models at once instead of migrating after each model generation
            - Cause: In db/migrate/create_flights.rb, foreign_key: true was used for departure_airport and arrival_airport references, but these both point to the same airports table.
                - Lesson learned: Migrate step-by-step after each model generation to catch and fix migration details early.