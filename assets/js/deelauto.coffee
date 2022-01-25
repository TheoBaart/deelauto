---
---

# define base classes

class Journey
  constructor: (@kilometers, @minutes)
  
# test
trip = new Journey(10,30)
console.log(trip)


# initiate interactivity!
$ -> 
  $('#test_button').click ->
        alert('hello world')
