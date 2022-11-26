---
---

# define generic classes

class Journey
    constructor: (@kilometers, @minutes, @hours) ->
    
class Car
    constructor: (@id, @vendor) ->
        
    computeJourneyPrice: (journey) ->
        return -999
 
## MYWHEELS ##
class MyWheelsCar extends Car
    constructor: (@id, @feehours, @feekilometers, @discount) ->
        @vendor = "MyWheels"
    
    computeJourneyPrice: (journey, usedDiscount = @discount) ->

        # note if trip > 2 times max day tariff you get 25% discount
        if journey.hours >= 38
            discountedhours = @feehours - (@feehours * 25/100)
            discountedkilometers = @feekilometers - (@feekilometers * 25/100)
            discounts = "25% korting (Meerdagen)" 
        else if usedDiscount is 0
            discountedhours = @feehours
            discountedkilometers = @feekilometers
            discounts = "geen"
        else
            discountedhours = @feehours * (1 - usedDiscount/100)
            discountedkilometers = @feekilometers * (1 - usedDiscount/100)
            discounts = switch
                when usedDiscount is 15 then usedDiscount + "% korting (Plus)" 
                when usedDiscount is 25 then usedDiscount + "% korting (Pro)"
                else usedDiscount + "% korting" 
        
        # compute time component
        unpaidhours = Math.ceil(journey.hours) # pay per hour
        timecomponent = 0
        
        while unpaidhours > 0
            paidhours = Math.min(24, unpaidhours)
            timecomponent += (Math.min(10, paidhours)*discountedhours)
            unpaidhours -= paidhours
            
        # compute distance component
        distancecomponent = (journey.kilometers * discountedkilometers)
        
        # compute fee
        bestFee = (timecomponent + distancecomponent)
        bestFee = Math.round(bestFee*100)/100 # two decimal places
        
        return {fee:bestFee, packages:discounts}
    
    updateDiscount: (newdiscount) ->
        @discount = newdiscount
            
instantiateMyWheelsCars = ->
            
    # define cars
    fiat500 = new MyWheelsCar("Fiat 500", 3.25, 0.32, 0)
    toyotaAygo = new MyWheelsCar("Toyota Aygo", 3.25, 0.32, 0)
    citroenC1 = new MyWheelsCar("Citroën C1", 3.25, 0.32, 0)
    
    skodaCitigoe = new MyWheelsCar("Skoda CITIGOe", 3.25, 0.30, 0)
    seatMiielectric = new MyWheelsCar("Seat Mii Electric", 3.25, 0.30, 0)

    citroenC3 = new MyWheelsCar("Citroën C3", 3.75, 0.35, 0)
    toyotaYarishybrid = new MyWheelsCar("Toyota Hybrid Yaris", 3.75, 0.35, 0)
    renaultClio = new MyWheelsCar("Renault Clio", 3.75, 0.35, 0)
    opelCorsa = new MyWheelsCar("Opel Corsa", 3.75, 0.35, 0)
    nissanMicra = new MyWheelsCar("Nissan Micra", 3.75, 0.35, 0)
    volkswagenPolo = new MyWheelsCar("Volkswagen Polo", 3.75, 0.35, 0)
    miniOne = new MyWheelsCar("Mini One", 3.75, 0.35, 0)
    
    renaultZoe = new MyWheelsCar("Renault ZOE", 3.75, 0.33, 0)
    nissanLeaf = new MyWheelsCar("Nissan Leaf", 3.75, 0.33, 0)
    peugeotE208 = new MyWheelsCar("Peugeot E-208", 3.75, 0.33, 0)
    miniCooperelectric = new MyWheelsCar("Mini Cooper Electric", 3.75, 0.33, 0)
    
    fordFocuswagon = new MyWheelsCar("Ford Focus Wagon", 4.25, 0.38, 0)
    opelAstratourer = new MyWheelsCar("Opel Astra Tourer", 4.25, 0.38, 0)
    
    hyundaiKona = new MyWheelsCar("Hyundai Kona", 4.25, 0.36, 0)
    kiaEniro = new MyWheelsCar("Kia e-Niro", 4.25, 0.36, 0)
    aiwaysU5 = new MyWheelsCar("Aiways U5", 4.25, 0.36, 0)
    
#     define cars array
    cars = [fiat500, toyotaAygo, citroenC1, skodaCitigoe, seatMiielectric, citroenC3, toyotaYarishybrid, renaultClio, opelCorsa, nissanMicra, volkswagenPolo, miniOne, renaultZoe, nissanLeaf, peugeotE208, miniCooperelectric, fordFocuswagon, opelAstratourer, hyundaiKona, kiaEniro, aiwaysU5]
    
    return cars

## SIXT SHARE ##
class SixtShareCar extends Car
    constructor: (@id, @feeminutes) ->
        @vendor = "Sixt Share"
        @feekilometers = 0.34 # irrespective of car/package when going beyond included kilometers
        @feeextratime = 0.28 # irrespective of car when going beyond package time
        @includedkilometers = 200 # if not using package & irrespective of car/package
        @distancePackages = []
        @timePackages = []
    
    addDistancePackage: (packageName, packagePrice, packageDistance) ->
        distancePackage = {name: packageName, kilometers:packageDistance, price:packagePrice}
        @distancePackages.push distancePackage
        
    addTimePackage: (packageName, packagePrice, packageTime, timeUnit, packageKilometers) ->
        packageHours = switch
            when timeUnit is "minutes" then packageTime / 60
            when timeUnit is "days" then packageTime * 24
            else packageTime
        timePackage = {name: packageName, hours: packageHours, price:packagePrice, kilometers: packageKilometers}
        @timePackages.push timePackage
        
    getBestDistancePackage: (journeyKilometers, packageKilometers, kilometerFee) ->
        unpaidKilometers = Math.max((journeyKilometers - packageKilometers),0)
        
        alreadyIncluded = unpaidKilometers * kilometerFee # base case
        bestPackage = {name:"geen kilometer pakket",fee:alreadyIncluded}
 
        if unpaidKilometers > 0
            for distancePackage in @distancePackages
                excludedkilometers = Math.max((unpaidKilometers - distancePackage.kilometers),0)
                distancePackageFee = distancePackage.price + (excludedkilometers * kilometerFee)
            
                if distancePackageFee < bestPackage.fee
                    bestPackage.fee = distancePackageFee
                    bestPackage.name = distancePackage.name
                
        return bestPackage
        
    computeJourneyPriceMinuteOverride:(journey, override) ->
        @computeJourneyPrice(journey, override, @feekilometers)
        
    computeJourneyPriceKilometerOverride:(journey, override) ->
        @computeJourneyPrice(journey, @feeminutes, override)
        
    computeJourneyPrice: (journey, usedMinutefee = @feeminutes, usedKilometerfee = @feekilometers) ->
        # base fee (no packages)
        baseTimeFee = (journey.minutes * usedMinutefee)
        baseDistanceFee = Math.max((journey.kilometers - @includedkilometers),0) * usedKilometerfee
        baseFee = baseTimeFee + baseDistanceFee
        packagesUsed = "geen"
        
        bestFee = baseFee
        # see if km packages can improve on this situation
        distancePackage = @getBestDistancePackage(journey.kilometers, @includedkilometers, usedKilometerfee)
        if (baseTimeFee + distancePackage.fee) < bestFee
            bestFee = (baseTimeFee + distancePackage.fee)
            packagesUsed = ("geen tijd pakket en "+distancePackage.name)
        
        # see if time (+ km) packages can improve on this situation
        for timePackage in @timePackages
            uncoveredminutes = Math.max(journey.minutes - (timePackage.hours*60), 0)
            timePackageFee = timePackage.price + (uncoveredminutes * @feeextratime)
            
            distancePackage = @getBestDistancePackage(journey.kilometers, timePackage.kilometers, usedKilometerfee)
            
            packageFee = timePackageFee + distancePackage.fee
            
            if packageFee < bestFee
                bestFee = packageFee
                packagesUsed = (timePackage.name + " en " + distancePackage.name)
        
        
        # compute fee
        bestFee = Math.round(bestFee*100)/100 # two decimal places
                             
        return {fee:bestFee, packages:packagesUsed}
        
        
instantiateSixtShareCars = ->
#    define cars
    
    # budget cars array
    seatMii = new SixtShareCar("Seat Mii", 0.27)
    skodaCitigo = new SixtShareCar("Skoda CITIgo", 0.27)
    
    budgetcars = [seatMii, skodaCitigo]
    for budget in budgetcars
        # added backwards for easier math
        budget.addTimePackage("7 Dagen Pakket", 209, 7, "days", 600)
        budget.addTimePackage("3 Dagen Pakket", 95, 3, "days", 400)
        budget.addTimePackage("1 Dag Pakket", 69, 1, "days", 200)
        budget.addTimePackage("6 Uur Pakket", 49, 6, "hours", 120)
        budget.addTimePackage("3 Uur Pakket", 32, 3, "hours", 80)
        
    # standard cars array
    nissanLeaf = new SixtShareCar("Nissan Leaf", 0.29)
    hyundaiKona = new SixtShareCar("Hyundai Kona", 0.29)
    ds3crossback = new SixtShareCar("DS 3 Crossback", 0.29)
    
    standardcars = [nissanLeaf,hyundaiKona,ds3crossback]
    for standard in standardcars
        # added backwards for easier math
        standard.addTimePackage("7 Dagen Pakket", 229, 7, "days", 600)
        standard.addTimePackage("3 Dagen Pakket", 109, 3, "days", 400)
        standard.addTimePackage("1 Dag Pakket", 79, 1, "days", 200)
        standard.addTimePackage("6 Uur Pakket", 59, 6, "hours", 120)
        standard.addTimePackage("3 Uur Pakket", 35, 3, "hours", 80)
    
    # premium cars array
    bmwi3 = new SixtShareCar("BMW i3", 0.31)
    aiwaysU5 = new SixtShareCar("Aiways U5", 0.31)
    volkswagenGolf = new SixtShareCar("Volkswagen Golf", 0.31)
    premiumcars = [bmwi3,aiwaysU5,volkswagenGolf]
    for premium in premiumcars
        # added backwards for easier math
        premium.addTimePackage("7 Dagen Pakket", 249, 7, "days", 600)
        premium.addTimePackage("3 Dagen Pakket", 119, 3, "days", 400)
        premium.addTimePackage("1 Dag Pakket", 89, 1, "days", 200)
        premium.addTimePackage("6 Uur Pakket", 69, 6, "hours", 120)
        premium.addTimePackage("3 Uur Pakket", 45, 3, "hours", 80)
    
#    define cars array
    cars = [budgetcars..., standardcars..., premiumcars...]

    # add kilometer packages
    for car in cars
        # added backwards for easier math
        car.addDistancePackage("500 Kilometer Pakket", 110, 500)
        car.addDistancePackage("250 Kilometer Pakket", 60, 250)
        car.addDistancePackage("150 Kilometer Pakket", 39, 150)
        car.addDistancePackage("100 Kilometer Pakket", 27, 100)
        car.addDistancePackage("50 Kilometer Pakket", 14, 50)
    
    return cars

instantiate = (cars) ->
    vendors = ["MyWheels","Sixt Share"]
    
    # mywheels
    newcars = instantiateMyWheelsCars()
    for car in newcars
        cars.push car
    
    # sixt
    newcars = instantiateSixtShareCars()
    for car in newcars
        cars.push car
    
    select = $("#vendors")
    select.empty()
    for vendor in vendors
       opt = document.createElement("option")
       opt.text = vendor
       opt.value = vendor
        
       select.append(opt)
            
    updateCarsDropdown(vendors[0], cars)    
    
    return cars

# initiate interactivity!

addRowRecentResultsTable = (vendor, car, journey, journeyPrice) ->
    header = $('#recent_results tr:first')
    col = "</td><td>"
    row = ("<tr><td>"+vendor+col+car+col+journey.kilometers+col+journey.minutes+col+journey.hours+col+journeyPrice.fee+col+journeyPrice.packages+"</tr></td>")
    header.after(row)
    
addRowAllResultsTable = (vendor, car, journey, journeyPrice,activeCar) ->
    col = "</td><td>"
    if activeCar
        row = ("<tr class=\"highlighted_row\">    <td>"+vendor+col+car+col+journey.kilometers+col+journey.minutes+col+journey.hours+col+journeyPrice.fee+col+journeyPrice.packages+"</tr></td>")
        $("#all_results_body").append(row)
    else
        row = ("<tr>    <td>"+vendor+col+car+col+journey.kilometers+col+journey.minutes+col+journey.hours+col+journeyPrice.fee+col+journeyPrice.packages+"</tr></td>")
        $("#all_results_body").append(row)

updateCarsDropdown = (new_vendor, cars) ->
    car_names = []
    for car in cars
        if car.vendor is new_vendor
            car_names.push car.id
  
    # update car dropdown
    select = $("#cars")
    select.empty()
    for car in car_names
        opt = document.createElement("option")
        opt.text = car
        opt.value = car
        select.append(opt)
   
clearText = ->
    $('#journey_price').text("")
    $('#journey_discounts').text("")

handleSixtOverrides = (car, journey) ->
    min_override = parseFloat($('#minuteoverride').val()).toFixed(2)
    km_override = parseFloat($('#kilometeroverride').val()).toFixed(2)
    sixt_min_override = $('#sixt_min_toggle').is(":checked")
    sixt_km_override = $('#sixt_km_toggle').is(":checked")
    if sixt_min_override and sixt_km_override
        return car.computeJourneyPrice(journey, min_override, km_override)
    else if sixt_min_override or sixt_km_override
        if sixt_min_override
            return car.computeJourneyPriceMinuteOverride(journey, min_override)
        else
            return car.computeJourneyPriceKilometerOverride(journey, km_override)
    else
       return car.computeJourneyPrice(journey)
    
handleMyWheelsOverrides = (car, journey) ->
    journeyPrice = switch
        when $('#mywheels_subscription').val() is "plus" then car.computeJourneyPrice(journey, 15) # 15% discount
        when $('#mywheels_subscription').val() is "pro" then car.computeJourneyPrice(journey, 25) # 25% discount
        else car.computeJourneyPrice(journey) # no discount
    return journeyPrice
    
handleJourney = (journey, car, selected) ->
    # SIXT OVERRIDE?    
    if car.vendor is "Sixt Share"
        journeyPrice = handleSixtOverrides(car, journey)
    # MYWHEELS OVERRIDE
    else if car.vendor is "MyWheels"
        journeyPrice = handleMyWheelsOverrides(car, journey)
    # DEFAULT
    else
        journeyPrice = car.computeJourneyPrice(journey)
    if selected
        fee = journeyPrice.fee
        $('#journey_price').text(fee+" euro")
        discounts = journeyPrice.packages
        $('#journey_discounts').text(discounts)
        console.log(car.id+ " ("+car.vendor+") for "+fee+" euros using "+discounts)
        addRowRecentResultsTable(car.vendor, car.id, journey, journeyPrice)
        addRowAllResultsTable(car.vendor, car.id, journey, journeyPrice, true)
    else
        addRowAllResultsTable(car.vendor, car.id, journey, journeyPrice, false)

computeCars = (journey) ->
    selected_vendor_name = $("#vendors").val()
    selected_car_name = $("#cars").val()

    # clear ResultsTable
    $('#all_results > tbody').empty()

    for car in window.cars
        if (car.id is selected_car_name and car.vendor is selected_vendor_name)
            handleJourney(journey, car, true)
        else
            handleJourney(journey, car, false)
 
    
updateCustomization = ->
    vendor = $("#vendors").val()
    if vendor is "MyWheels"
        $("#customized_sixt").addClass("hidden")
        if($('#mywheels_subscription').val() is "plus")
            $("#plus_fee").removeClass("hidden")
            $("#pro_fee").addClass("hidden")
        else if($('#mywheels_subscription').val() is "pro")   
            $("#plus_fee").addClass("hidden")
            $("#pro_fee").removeClass("hidden")
        else
            $("#plus_fee").addClass("hidden")
            $("#pro_fee").addClass("hidden")
        $("#customized_mywheels").removeClass("hidden")
            
    else if vendor is "Sixt Share"
        $("#customized_sixt").removeClass("hidden")
        $("#customized_mywheels").addClass("hidden")
    else
        $("#customized_sixt").addClass("hidden")
        $("#customized_mywheels").addClass("hidden")
    
$(document).ready -> 
    window.cars = instantiate([])
    updateCustomization()
    $('#recent_toggle').prop("checked",true)
    $('#all_toggle').prop("checked",false)
    
    $('#vendors').change (event) ->
        event.preventDefault()
        clearText()
        updateCustomization()
        updateCarsDropdown($("#vendors").val(),window.cars)
        
    $('#mywheels_subscription').change (event) ->
        event.preventDefault()
        clearText()
        updateCustomization()
    
    $('#cars').change (event) ->
        event.preventDefault()
        clearText()
        
    # handle button press submission
    $('#calculate').click (event) ->
#        alert("CLICK")
        event.preventDefault()
        journey_units = $('#journey_units').val()
        kilometers = parseInt($('#journey_kilometers').val(),10)
        duration = parseInt($('#journey_duration').val(),10)
        if (kilometers > 0) and (duration > 0) 
            if journey_units is "days"
                hours = duration * 24
                minutes = (hours * 60)
            else if journey_units is "hours"
                hours = duration
                minutes = (hours * 60)
            else
                minutes = duration
                hours = (minutes / 60)
            journey = new Journey(kilometers, minutes, hours) 
            
            computeCars(journey)
        else
            alert("Afstand of duur data is niet compleet!")

    $('#all_toggle').click (event) ->
        if $('#all_toggle').is(":checked")
            $('#all_results_container').removeClass("hidden")
        else
            $('#all_results_container').addClass("hidden")
#
#   $('#recent_toggle').click (event) ->
#        if $('#recent_toggle').is(":checked")
#            $('#recent_results_container').removeClass("hidden")
#        else
#            $('#recent_results_container').addClass("hidden")
