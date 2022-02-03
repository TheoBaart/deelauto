---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

<link rel="shortcut icon" type="image/x-icon" href="{{ "/assets/favicon.ico" | relative_url }}">

<script type = "text/javascript"
         src = "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

 <script src="{{ "/assets/js/deelauto.js" | relative_url }}"></script>

**Let op!** Sommige providers rekenenen met variable tarieven (op basis van vraag/aanbod en locatie). De tarieven in deze applicatie zijn dus vooral een indicatie. Daadwerkelijke kosten kunnen verschillen. *Laatste prijsupdate 30 januari 2022.*

<div class="float_container">
    <div class="float_content">
        <label for="vendors">Deelauto provider:</label>
        <select name="vendors" id="vendors">
            <option value="none">Selecteer een provider</option>
        </select>
        <br>
        <label for="cars">Auto:</label>
        <select name="cars" id="cars">
            <option value="none">Selecter eerst een provider</option>
        </select>
    </div>
    <div class="float_content">
        <label for="journey_km">Rit afstand: </label>
        <input type="number" id="journey_kilometers" name="journey_kilometers" min="1" required > (kilometers)
        <br>
        <label for="journey_min">Rit duur: </label>
        <input type="number" id="journey_duration" name="journey_duration" min="1" required >
        <label class="toggl">
            <input id="timeunittoggl" type="checkbox"><span class="toggl round"></span>
        </label>
    </div>
</div>

<hr>

<div id="customization" class="customized hidden">
    <div id="customized_sixt" class="hidden">
         <p><em>De geselecteerde deelauto provider gebruikt vaak variable tarieven. Gebruik het menu hieronder om eventueel zelf de tarieven in te stellen</em></p>
        <br>    
        <label class="toggl">
            <input id="timetoggl" type="checkbox"><span class="toggl round"></span>
        </label>
        <label for="timeoverride">Kosten per minuut:</label><input type="number" id="timeoverride" name="timeoverride">
        <br>
        <label class="toggl">
            <input id="kilometertoggl" type="checkbox"><span class="toggl round"></span>
        </label>
        <label for="kilometeroverride">Kosten per kilometer:</label><input type="number" id="kilometeroverride" name="kilometeroverride">
        <br>
    </div>
    <div id ="customized_mywheels" class="hidden">
        <p><em>De geselecteerde deelauto heeft verschillende soorten abbonement. Welke is van toepassing voor deze rit?</em> TODO CONVERT TO THREE TOGGLE</p>
        <br>
        <label class="toggl">
            <input id="kilometertoggl" type="checkbox"><span class="toggl round"></span>
        </label>
    </div>
    <hr>
</div>




  <button id="calculate" type="button">Bereken!</button>

Deze rit kost ongeveer: <em><span id="journey_price"></span></em>

De volgende kortingen en/of pakketen zijn actief:
<em><span id="journey_discounts"></span></em>

Laat recente ritten zien <label class="toggl">
   <input id="kilometertoggl" type="checkbox"><span class="toggl round"></span>
</label>
<br>
Recente Ritten:
<table id="recent_results">
    <tr>
        <th>Provider</th>
        <th>Auto</th>
        <th>Rit afstand (kilometers</th>
        <th>Rit duur (minuten)</th>
        <th>Rit kosten</th>
        <th>Rit kortingen en/of pakketen</th>
    </tr>
</table>


Laat alle autos zien <label class="toggl">
   <input id="kilometertoggl" type="checkbox"><span class="toggl round"></span>
</label>
<br>
Alle Autos:
<table id="all_results">
    <tr>
        <th>Provider</th>
        <th>Auto</th>
        <th>Rit afstand (kilometers</th>
        <th>Rit duur (minuten)</th>
        <th>Rit kosten</th>
        <th>Rit kortingen en/of pakketen</th>
    </tr>
</table>
