---
---

# define journey-related classes

class Journey
    constructor: (@kilometers, @minutes, @hours) ->
    
# define vehicle-related classes
class Car
    constructor: (@id, @vendor) ->
        
    computeJourneyPrice: (journey) ->
        return -999
 
class MyWheelsCar extends Car
    constructor: (@id, @feehours, @feekilometers, @discount) ->
        @vendor = "MyWheels"
    
    computeJourneyPrice: (journey) ->
        console.log("fees: " + @feehours + "/hour, "+@feekilometers + "/kilometer with "+@discount+"% discount")
        
        # compute time component
        unpaidhours = journey.hours
        timecomponent = 0
        
        while unpaidhours > 0
            paidhours = Math.min(24, unpaidhours)
            timecomponent += (Math.min(10, paidhours)*@feehours)
            unpaidhours -= paidhours
            
        # compute distance component
        distancecomponent = (journey.kilometers * @feekilometers)
        
        # compute fee
        fee = (timecomponent + distancecomponent)
        
        return fee
    
    updateDiscount: (newdiscount) ->
        @discount = newdiscount
            
# instantiation functions        
instantiateMyWheelsCars = ->
            
    # define cars
    fiat500 = new MyWheelsCar("Fiat 500", 3, 0.29, 0)
    toyotaAygo = new MyWheelsCar("Toyota Aygo", 3, 0.29, 0)
    citroenC1 = new MyWheelsCar("Citroën C1", 3, 0.29, 0)
    
    skodaCitigoe = new MyWheelsCar("Skoda CITIGOe", 3, 0.27, 0)
    seatMiielectric = new MyWheelsCar("Seat Mii Electric", 3, 0.27, 0)

    citroenC3 = new MyWheelsCar("Citroën C3", 3.5, 0.32, 0)
    toyotaYarishybrid = new MyWheelsCar("Toyota Hybrid Yaris", 3.5, 0.32, 0)
    renaultClio = new MyWheelsCar("Renault Clio", 3.5, 0.32, 0)
    opelCorsa = new MyWheelsCar("Opel Corsa", 3.5, 0.32, 0)
    nissanMicra = new MyWheelsCar("Nissan Micra", 3.5, 0.32, 0)
    volkswagenPolo = new MyWheelsCar("Volkswagen Polo", 3.5, 0.32, 0)
    miniOne = new MyWheelsCar("Mini One", 3.5, 0.32, 0)
    
    renaultZoe = new MyWheelsCar("Renault ZOE", 3.5, 0.30, 0)
    nissanLeaf = new MyWheelsCar("Nissan Leaf", 3.5, 0.30, 0)
    peugeotE208 = new MyWheelsCar("Peugeot E-208", 3.5, 0.30, 0)
    miniCooperelectric = new MyWheelsCar("Mini Cooper Electric", 3.5, 0.30, 0)
    
    fordFocuswagon = new MyWheelsCar("Ford Focus Wagon", 4, 0.35, 0)
    opelAstratourer = new MyWheelsCar("Opel Astra Tourer", 4, 0.35, 0)
    
    hyundaiKona = new MyWheelsCar("Hyundai Kona", 4, 0.33, 0)
    kiaEniro = new MyWheelsCar("Kia e-Niro", 4, 0.33, 0)
    aiwaysU5 = new MyWheelsCar("Aiways U5", 4, 0.33, 0)
    
#     define cars array
    cars = [fiat500, toyotaAygo, citroenC1, skodaCitigoe, seatMiielectric, citroenC3, toyotaYarishybrid, renaultClio, opelCorsa, nissanMicra, volkswagenPolo, miniOne, renaultZoe, nissanLeaf, peugeotE208, miniCooperelectric, fordFocuswagon, opelAstratourer, hyundaiKona, kiaEniro, aiwaysU5]
    
    return cars

# initiate interactivity!

instantiate = (cars) ->
    vendors = ["MyWheels"]
    
    # mywheels
    newcars = instantiateMyWheelsCars()
    for car in newcars
        cars.push car
    
    # sixt
#    newcars = instantiateSixtShareCars()
#    for car in newcars
#        cars.push car
    
    select = $("#vendors")
    select.empty()
    for vendor in vendors
       opt = document.createElement("option")
       opt.text = vendor
       opt.value = vendor
        
       select.append(opt)
            
    updateCarsDropdown(vendors[0], cars)    
    
    return cars

updateCarsDropdown = (new_vendor, cars) ->
    car_names = []
    for car in cars
        if car.vendor = new_vendor
            car_names.push car.id
    
    # update car dropdown
    select = $("#cars")
    select.empty()
    for car in car_names
        opt = document.createElement("option")
        opt.text = car
        opt.value = car
        select.append(opt)
            
handleJourney = (journey, cars) ->
    vendor_name = $('#vendors').val()
    car_name = $('#cars').val()

    for car in cars
        if (car.id is car_name) && (car.vendor is vendor_name)
            selected = car
            break
            
    if selected?
        fee = selected.computeJourneyPrice(journey)
        $('#journey_price').text(fee+" euro")
    else
        $('#journey_price').text("")
        alert("Selecteer eerst een auto!")
    
$(document).ready -> 
    window.cars = instantiate([])

    $('#vendors').change (event) ->
        event.preventDefault()
        $('#journey_price').text("")
        updateCarsDropdown($("#vendors").val(),window.cars)
    
    $('#cars').change (event) ->
        event.preventDefault()
        $('#journey_price').text("")    
    
    # handle form submission
    $('#journey_form').submit (event) ->
        event.preventDefault()
        kilometers = parseInt($('#journey_kilometers').val(),10)
        minutes = parseInt($('#journey_minutes').val(),10)
        hours = (minutes / 60)
        journey = new Journey(kilometers, minutes, hours) 
        handleJourney(journey, window.cars)
