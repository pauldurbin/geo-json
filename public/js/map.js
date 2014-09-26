function initialize() {
  setupFilters();

  var mapOptions = {
    center: new google.maps.LatLng(53.7951774597168, -1.5521142482757568),
    zoom: 11
  };
  var map = new google.maps.Map(document.getElementById("jsonMap"), mapOptions);
  var infoWindow = new google.maps.InfoWindow({ content: "" });
  var features = []

  map.data.addListener('click', function(event) {
    infoWindow.setContent('<div style="line-height:1.35;overflow:hidden;white-space:nowrap;">' +
            event.feature.getProperty("OrganisationName") + "<br />" +
            event.feature.getProperty("Address1") + "<br />" +
            event.feature.getProperty("Address2") + "<br />" +
            event.feature.getProperty("Postcode") + "<br />" +
            "</div>");
    var anchor = new google.maps.MVCObject();
    anchor.set("position", event.latLng);
    infoWindow.open(map, anchor);
  });

  map.data.setStyle(function(feature) {
    return { icon:feature.getProperty('icon') };
  });
  
  google.maps.event.addListener(map, 'idle', function(event) {
    updateMap();
  });

  $('form#location').on('submit', function(e) {
    e.preventDefault();
    lat = $("#search_latitude").val();
    lng = $("#search_longitude").val();
    if (lat && lng)
      map.panTo(new google.maps.LatLng(lat, lng));
  });

  $('.filters input').on('click', function() {
    updateMap();
  })

  function updateMap() {
    var bounds = map.getBounds();

    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();

    for (var i = 0; i < features.length; i++)
      map.data.remove(features[i]);

    filters = [];
    $('.filters input:checked').each(function() {
      filters.push($(this).val());
    });
    if (filters.length > 0)
      filters = 'type=' + filters.join(",") + '&';

    $.getJSON('/geo/services.geojson?' + filters + 'ne=' + ne.lat() + ',' + ne.lng() + '&sw=' + sw.lat() + ',' + sw.lng(), function (data) {
      features = map.data.addGeoJson(data);
    });
  }
}
google.maps.event.addDomListener(window, 'load', initialize);

function setupFilters() {
  map = $('#jsonMap');
  new_filters = '';
  $.each(types, function(k, v) {
    new_filters += '<div class="small-2 columns"><p style="text-transform: capitalize;"><input type="checkbox" id="types_' + v + '" name="types[]" value="' + v + '" checked="checked" /> <label for="types_' + v + '">' + v + '</label></p></div>';
  });
  row = '<div class="row filters">' + new_filters + '</div>';
  map.before(row);
}
