---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

<link rel="shortcut icon" type="image/x-icon" href="{{ "/assets/favicon.ico" | relative_url }}">

<script type = "text/javascript"
         src = "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

 <script src="{{ "/assets/js/deelauto.js" | relative_url }}"></script>

**Let op!** Sommige providers rekenenen met variable tarieven (op basis van vraag/aanbod). De tarieven in deze applicatie zijn dus vooral een indicatie. Daadwerkelijke kosten kunnen verschillen. *Laatste prijsupdate 30 januari 2022.*

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

Deze rit kost ongeveer: <em><span id="journey_price"></span></em>

De volgende kortingen en/of pakketen zijn actief:
<em><span id="journey_discounts"></span></em>