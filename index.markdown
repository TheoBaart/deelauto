---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

<script type = "text/javascript"
         src = "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

 <script src="{{ "/assets/js/deelauto.js" | relative_url }}"></script>

Dit is iets heel simple. Nu iets minder


<form id="journey_form">
    <label for="journey_km">Rit afstand (kilometers): </label>
    <input type="number" id="journey_kilometers" name="journey_kilometers" min="1" required >
    <br>
    <label for="journey_min">Rit duur (minuten): </label>
    <input type="number" id="journey_minutes" name="journey_minutes" min="1" required >
    <br>
  <button type="submit">Submit</button>
</form>
