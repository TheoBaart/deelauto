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
                when usedDiscount is 30 then usedDiscount + "% korting (Pro)"
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
    fiat500 = new MyWheelsCar("Fiat 500", 3.50, 0.37, 0)
    toyotaAygo = new MyWheelsCar("Toyota Aygo", 3.50, 0.37, 0)
    citroenC1 = new MyWheelsCar("Citroën C1", 3.50, 0.37, 0)
    
    skodaCitigoe = new MyWheelsCar("Skoda CITIGOe", 3.50, 0.37, 0)
    seatMiielectric = new MyWheelsCar("Seat Mii Electric", 3.50, 0.37, 0)

    genericSmall = new MyWheelsCar("Generic Small", 3.50, 0.37, 0)

    citroenC3 = new MyWheelsCar("Citroën C3", 4.00, 0.40, 0)
    toyotaYarishybrid = new MyWheelsCar("Toyota Hybrid Yaris", 4.00, 0.40, 0)
    renaultClio = new MyWheelsCar("Renault Clio", 4.00, 0.40, 0)
    opelCorsa = new MyWheelsCar("Opel Corsa", 4.00, 0.40, 0)
    nissanMicra = new MyWheelsCar("Nissan Micra", 4.00, 0.40, 0)
    miniOne = new MyWheelsCar("Mini One", 4.00, 0.40, 0)
    
    renaultZoe = new MyWheelsCar("Renault ZOE", 4.00, 0.40, 0)
    nissanLeaf = new MyWheelsCar("Nissan Leaf", 4.00, 0.40, 0)
    peugeotE208 = new MyWheelsCar("Peugeot E-208", 4.00, 0.40, 0)

    genericMedium = new MyWheelsCar("Generic Medium", 4.00, 0.40, 0)
    
    fordFocuswagon = new MyWheelsCar("Ford Focus Wagon", 4.50, 0.43, 0)
    opelAstratourer = new MyWheelsCar("Opel Astra Tourer", 4.50, 0.43, 0)
    
    hyundaiKona = new MyWheelsCar("Hyundai Kona", 4.50, 0.43, 0)
    kiaEniro = new MyWheelsCar("Kia e-Niro", 4.50, 0.43, 0)
    mgMg4 = new MyWheelsCar("MG MG4", 4.50, 0.43, 0)
    volkswagenID3 = new MyWheelsCar("Volkswagen ID.3", 4.50, 0.43, 0)
    MWbmwI3  = new MyWheelsCar("BMW i3", 4.50, 0.43, 0)
    ds3Etense = new MyWheelsCar("DS 3 E-Tense", 4.50, 0.43, 0)
    
    genericLarge = new MyWheelsCar("Generic Large", 4.50, 0.43, 0)
    
#     define cars array
    cars = [fiat500, toyotaAygo, citroenC1,
            skodaCitigoe, seatMiielectric, 
            genericSmall,
            citroenC3, toyotaYarishybrid, renaultClio, opelCorsa, nissanMicra, miniOne,
            renaultZoe, nissanLeaf, peugeotE208, 
            genericMedium,
            fordFocuswagon, opelAstratourer, 
            hyundaiKona, kiaEniro, mgMg4, volkswagenID3, MWbmwI3, ds3Etense,
            genericLarge
           ]
    
    return cars

## SIXT SHARE ##
class SixtShareCar extends Car
    constructor: (@id, @feeminutes, @feeunlock) ->
        @vendor = "Sixt Share"
        @feekilometers = 0.39 # irrespective of car/package when going beyond included kilometers
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
        
    computeJourneyPrice: (journey, usedMinutefee = @feeminutes, usedKilometerfee = @feekilometers, usedUnlockfee = @feeunlock) ->
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

        # add unlock fee
        bestFee = bestFee + usedUnlockfee
        return {fee:bestFee, packages:packagesUsed}
        
        
instantiateSixtShareCars = ->
#    define cars
    
    # budget cars array
    nissanLeaf = new SixtShareCar("Nissan Leaf", 0.30, 1)
    peugeot2008e = new SixtShareCar("Peugeot 2008-e", 0.30, 1)
    opelMokkae = new SixtShareCar("Opel Mokka-e", 0.30, 1)
    mgZs = new SixtShareCar("MG ZS", 0.30, 1)
    bmwi3 = new SixtShareCar("BMW i3", 0.30, 1)
    
    budgetcars = [nissanLeaf, peugeot2008e, opelMokkae,mgZs,bmwi3]
    for budget in budgetcars
        # added backwards for easier math
        budget.addTimePackage("7 Dagen Pakket", 349, 7, "days", 600)
        budget.addTimePackage("3 Dagen Pakket", 155, 3, "days", 400)
        budget.addTimePackage("2 Dagen Pakket", 109, 2, "days", 300)
        budget.addTimePackage("1 Dag Pakket", 69, 1, "days", 200)
        budget.addTimePackage("6 Uur Pakket", 46, 6, "hours", 120)
        budget.addTimePackage("3 Uur Pakket", 34, 3, "hours", 80)
        
    # standard cars array
    miniCooperSE = new SixtShareCar("Mini Cooper SE", 0.32, 1)
    peugeotE208 = new SixtShareCar("Peugeot e-208", 0.32, 1)
    mgMarvelR = new SixtShareCar("MG Marvel R", 0.32, 1)
    VwId3 = new SixtShareCar("VW ID.3", 0.32, 1)
    
    standardcars = [miniCooperSE,peugeotE208,mgMarvelR,VwId3]
    for standard in standardcars
        # added backwards for easier math
        standard.addTimePackage("7 Dagen Pakket", 419, 7, "days", 600)
        standard.addTimePackage("3 Dagen Pakket", 179, 3, "days", 400)
        standard.addTimePackage("2 Dagen Pakket", 125, 2, "days", 300)
        standard.addTimePackage("1 Dag Pakket", 79, 1, "days", 200)
        standard.addTimePackage("6 Uur Pakket", 53, 6, "hours", 120)
        standard.addTimePackage("3 Uur Pakket", 39, 3, "hours", 80)     
   
    # premium cars array
    skodaEnyaq = new SixtShareCar("Skoda Enyaq", 0.39, 3)
    
    premiumcars = [skodaEnyaq]
    for premium in premiumcars
        # added backwards for easier math
        premium.addTimePackage("7 Dagen Pakket", 489, 7, "days", 600)
        premium.addTimePackage("3 Dagen Pakket", 215, 3, "days", 400)
        premium.addTimePackage("2 Dagen Pakket", 149, 2, "days", 300)
        premium.addTimePackage("1 Dag Pakket", 95, 1, "days", 200)
        premium.addTimePackage("6 Uur Pakket", 64, 6, "hours", 120)
        premium.addTimePackage("3 Uur Pakket", 47, 3, "hours", 80)
    
#    define cars array
    cars = [budgetcars..., standardcars..., premiumcars...]

    # add kilometer packages
    for car in cars
        # added backwards for easier math
        car.addDistancePackage("1000 Kilometer Pakket", 189, 1000)
        car.addDistancePackage("750 Kilometer Pakket", 145, 750)
        car.addDistancePackage("500 Kilometer Pakket", 99, 500)
        car.addDistancePackage("250 Kilometer Pakket", 49, 250)
        car.addDistancePackage("150 Kilometer Pakket", 30, 150)
        car.addDistancePackage("100 Kilometer Pakket", 21, 100)
        car.addDistancePackage("50 Kilometer Pakket", 11, 50)
    
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
        when $('#mywheels_subscription').val() is "pro" then car.computeJourneyPrice(journey, 30) # 30% discount
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
