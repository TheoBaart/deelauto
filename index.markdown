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

<div class="grid-container">
    <div class="grid-child">
        <label for="vendors">Deelauto provider:</label>
        <select name="vendors" id="vendors">
            <option value="none">Selecteer een provider</option>
        </select>
        <br>
        <br>
        <label for="cars">Auto:</label>
        <select name="cars" id="cars">
            <option value="none">Selecter eerst een provider</option>
        </select>
    </div>
    <div class="grid-child">
        <label for="journey_km">Rit afstand: </label>
        <input type="number" id="journey_kilometers" name="journey_kilometers" min="1" size="5"> Kilometer(s)
        <br>
        <br>
        <label for="journey_min">Rit duur: </label>
        <input type="number" id="journey_duration" name="journey_duration" min="1"  size="5">
        <select name="journey_units" id="journey_units">
            <option value="minutes">Minuten</option>
            <option value="hours">Uur</option>
            <option value="days">Dag(en)</option>
        </select>
    </div>
</div>

<hr>

<div id="customization" class="customized">
    <div id="customized_sixt" class="hidden">
         <p><em>De geselecteerde deelauto provider gebruikt vaak variable tarieven. Gebruik het menu hieronder om eventueel zelf de tarieven in te stellen</em></p>
        <br>    
        <div class="toggle_container">
            <div class="toggle-child">
                <input id="sixt_min_toggle" class="cmn-toggle cmn-toggle-round" type="checkbox">
                <label for="sixt_min_toggle"></label>
            </div>
            <div class="toggle-child">
                <label for="minuteoverride">Kosten per minuut:</label><input type="number" id="minuteoverride" placeholder="in euros per minuut" step="0.01">
            </div>
        </div>
        <br>
        <div class="toggle_container">
            <div class="toggle-child">
                <input id="sixt_km_toggle" class="cmn-toggle cmn-toggle-round" type="checkbox">
                <label for="sixt_km_toggle"></label>
            </div>
            <div class="toggle-child">
                <label for="kilometeroverride">Kosten per kilometer:</label><input type="number" id="kilometeroverride" placeholder="in euros per kilometer" step="0.01">
            </div>
        </div>
    </div>
    <div id ="customized_mywheels" class="hidden">
        <p><em>De geselecteerde deelauto heeft verschillende soorten abbonement. Welke is van toepassing voor deze rit?</em></p>
        MyWheels Abbonement: 
        <select name="mywheels_subscription" id="mywheels_subscription">
            <option value="start">Start</option>
            <option value="plus">Plus</option>
            <option value="pro">Pro</option>
        </select>
    </div>
</div>
<hr>



<button id="calculate" type="button">Bereken!</button>

Deze rit kost ongeveer: <em><span id="journey_price"></span></em>

De volgende kortingen en/of pakketen zijn actief:
<em><span id="journey_discounts"></span></em>
  
<div class="toggle_container">
    <div class="toggle-child">
        <input id="all_toggle" class="cmn-toggle cmn-toggle-round" type="checkbox">
        <label for="all_toggle"></label>
    </div>
    <div class="toggle-child">
        Laat alle autos for deze rit zien 
    </div>
</div>

<div id="all_results_container" class="hidden">
    <br>
    <hr>
    <b>Alle Autos:</b>
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
    <br>
</div>
  
<!--
<div class="toggle_container">
    <div class="toggle-child">
        <input id="recent_toggle" class="cmn-toggle cmn-toggle-round" type="checkbox">
        <label for="recent_toggle"></label>
    </div>
    <div class="toggle-child">
        Laat recente ritten zien 
    </div>
</div>
-->
<hr>
<div id="recent_results_container">
    <b>Recente Ritten:</b>
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
    <br>
</div>