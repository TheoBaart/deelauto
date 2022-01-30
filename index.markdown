---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

<link rel="shortcut icon" type="image/x-icon" href="{{ "/assets/favicon.ico" | relative_url }}">

<script type = "text/javascript"
         src = "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

 <script src="{{ "/assets/js/deelauto.js" | relative_url }}"></script>

No consideration yet of maximum fees, discounts or bundles!

<label for="vendors">Deelauto provider:</label>
<select name="vendors" id="vendors">
    <option value="none">Selecteer een provider</option>
</select>

<label for="cars">Auto:</label>
<select name="cars" id="cars">
    <option value="none">Selecter eerst een provider</option>
</select>

<form id="journey_form">
    <label for="journey_km">Rit afstand (kilometers): </label>
    <input type="number" id="journey_kilometers" name="journey_kilometers" min="1" required >
    <br>
    <label for="journey_min">Rit duur (minuten): </label>
    <input type="number" id="journey_minutes" name="journey_minutes" min="1" required >
    <br>
  <button type="submit">Submit</button>
</form>

Deze rit kost ongeveer: <span id="journey_price"></span>