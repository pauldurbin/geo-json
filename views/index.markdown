#An example

Of our geo-json API interacting with a Google Map.

<form id="location">
  <div class="row">
    <div class="small-10">
      <div class="row">
        <div class="small-3 columns">
          <label for="right-label" class="right inline">Location</label>
        </div>
        <div class="small-7 columns">
          <input type="text" class="autocomplete" id="right-label" placeholder="E.g. LS1 4HR or Leeds.." />
          <input type="hidden" name="latitude" id="search_latitude" />
          <input type="hidden" name="longitude" id="search_longitude" />
        </div>
        <div class="small-2 columns">
          <input type="submit" class="button postfix" id="search" value="Go" />
        </div>
      </div>
    </div>
  </div>

  <script>var types = ['dentist', 'hospital']</script>
  <div id="jsonMap"></div>
</form>
