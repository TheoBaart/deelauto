---
---

# define base classes

# class Journey
#   constructor: (@kilometers, @minutes) ->
  
# test
# trip = new Journey(10,30)
# console.log(trip)

# class PriceModel
#   constructor: (@base_fee, @kilometer_fee, @time_fee, @time_unit, @included_kilometers, @included_time) ->
    
#   get_price (Journey): ->
#     remaining_kilometers = Journey.kilometers - @included_kilometers
#     console.log(remaining_kilometers)
#     if @time_unit = "hours"
#       remaining_time = (Journey.minutes * 60) - @included_time
#       # cannot have partial hours
#       remaining_time = Math.ceil(remaining_time)
#     else
#       remaining_time = Journey.minutes - @included_time
#       # minutes is default
#     return remaining_time

# initiate interactivity!
$(document).ready -> 
  $('#journey_form').submit ->
        kilometers = parseInt($('#journey_kilometers').val(),10)
        minutes = parseInt($('#journey_minutes').val(),10)
        alert('kilometers = '+kilometers+' minutes = '+minutes)
