---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

<script type = "text/javascript"
         src = "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

 <script src="{{ "/assets/js/deelauto.js" | relative_url }}"></script>

Dit is iets heel simple. Nu iets meer
<!-- {% raw %} -->
<form id="journey_form">
    <div>
        <label for="journey_km">Rit afstand (kilometers): </label>
        <input type="number" id="journey_km" name=" journey_km", min="1" required>
        <br>
        <label for="journey_min">Rit duur (minuten): </label>
        <input type="number" id="journey_min" name=" journey_min", min="1" required>
    </div>
    <div>
        <input type="submit">
    </div>
</form>
<!-- {% endraw %} -->
