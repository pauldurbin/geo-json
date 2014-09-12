$(function () {
  $(".autocomplete").autocomplete({
    source: function (request, response) {
      $.ajax({
        url: "http://www.nhs.uk/geo/" + request.term.replace(' ', '+'),
        success: function (data) {
          response($.map(data.matches, function (item) {
            return {
              label: item.name,
              value: item.name,
              latitude: item.latitude,
              longitude: item.longitude
            };
          }));
        }
      });
    },
    minLength: 2,
    select: function (event, ui) {
      $("#search_latitude").val(ui.item.latitude);
      $("#search_longitude").val(ui.item.longitude);
    },
    open: function () {
      $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
    },
    close: function () {
      $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
    }
  }).wrap('<div class="safetyAutocompleteWrapper" />');;
});
