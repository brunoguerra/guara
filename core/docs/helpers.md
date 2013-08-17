===

== Helpers

=== Formating Data

==== Lacale helpers
  #format_datetime datetime, format
   - Formats datetime value on default format or speciefid format

  #format_date
   - 

  #format_time
   - 

  #elapsed_time
   - Uses rails distance_of_time_in_words, who tells: reports the approximate distance in time between two Time, Date or DateTime objects or integers as seconds. Pass include_seconds: true if you want more detailed approximations when distance < 1 min, 29 secs. Distances are reported based on the following table:
   ```
    0 <-> 29 secs                                                             # => less than a minute
    30 secs <-> 1 min, 29 secs                                                # => 1 minute
    1 min, 30 secs <-> 44 mins, 29 secs                                       # => [2..44] minutes
    44 mins, 30 secs <-> 89 mins, 29 secs                                     # => about 1 hour
    89 mins, 30 secs <-> 23 hrs, 59 mins, 29 secs                             # => about [2..24] hours
    23 hrs, 59 mins, 30 secs <-> 41 hrs, 59 mins, 29 secs                     # => 1 day
    41 hrs, 59 mins, 30 secs  <-> 29 days, 23 hrs, 59 mins, 29 secs           # => [2..29] days
    29 days, 23 hrs, 59 mins, 30 secs <-> 44 days, 23 hrs, 59 mins, 29 secs   # => about 1 month
    44 days, 23 hrs, 59 mins, 30 secs <-> 59 days, 23 hrs, 59 mins, 29 secs   # => about 2 months
    59 days, 23 hrs, 59 mins, 30 secs <-> 1 yr minus 1 sec                    # => [2..12] months
    1 yr <-> 1 yr, 3 months                                                   # => about 1 year
    1 yr, 3 months <-> 1 yr, 9 months                                         # => over 1 year
    1 yr, 9 months <-> 2 yr minus 1 sec                                       # => almost 2 years
    2 yrs <-> max time or date                                                # => (same rules as 1 yr)
  ```
