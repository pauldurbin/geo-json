#Geo JSON Client

Below is a nice map showing all the dentists in England.  Oooo, there are many.

<form id="location">
  <div class="row">
    <div class="small-10">
      <div class="row">
        <div class="small-3 columns">
          <label for="right-label" class="right inline">Your location</label>
        </div>
        <div class="small-7 columns">
          <input type="text" class="autocomplete" id="right-label" placeholder="E.g. LS1 4HR or Leeds.." />
          <input type="hidden" name="latitude" id="search_latitude" />
          <input type="hidden" name="longitude" id="search_longitude" />
        </div>
        <div class="small-2 columns">
          <a href="#" class="button postfix" id="search">Go</a>
        </div>
      </div>
    </div>
  </div>
</form>

<div id="jsonMap"></div>
<div id="info"></div>
