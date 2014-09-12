function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(53.7951774597168, -1.5521142482757568),
    zoom: 11
  };
  var map = new google.maps.Map(document.getElementById("jsonMap"), mapOptions);
  var infoWindow = new google.maps.InfoWindow({ content: "" });
  var features = []

  map.data.addListener('click', function(event) {
    //show an infowindow on click   
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
  
  google.maps.event.addListener(map, 'idle', function(event) {
    var bounds = map.getBounds();

    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();

    for (var i = 0; i < features.length; i++)
      map.data.remove(features[i]);

    $.getJSON('/geo/dentists.geojson?ne=' + ne.lat() + ',' + ne.lng() + '&sw=' + sw.lat() + ',' + sw.lng(), function (data) {
      features = map.data.addGeoJson(data);
    });
  });

  $('#search').click(function(e) {
    e.preventDefault();
    map.panTo(new google.maps.LatLng($("#search_latitude").val(), $("#search_longitude").val()))
  })
}
google.maps.event.addDomListener(window, 'load', initialize);
