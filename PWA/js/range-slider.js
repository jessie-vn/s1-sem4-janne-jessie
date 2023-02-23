$( function() {
    let valString = "";
    $( "#slider-range" ).slider({
      range: true,
      min: 0,
      max: 24,
      values: [ 18, 24 ],
      slide: function( event, ui ) {
        /*if (ui.values[ 0 ] < 12) { 
            if (ui.values[ 1 ] < 12) {  valString = ui.values[ 0 ] + " AM - " + i.values[ 1 ] + " AM"; }
            else if (ui.values[ 1 ] === 12) { valString = ui.values[ 0 ] + " AM - " + i.values[ 1 ] + " PM"; }
            else if (ui.values[ 1 ] >= 12) { valString = ui.values[ 0 ] + " AM - " + i.values[ 1 ] - 12 + " PM"; }
        }
        else if (ui.values[ 0 ] === 12) {
            if (ui.values[ 1 ] < 12) {  valString = ui.values[ 0 ] + " PM - " + i.values[ 1 ] + " AM"; }
            else if (ui.values[ 1 ] === 12) { valString = ui.values[ 0 ] + " PM - " + i.values[ 1 ] + " PM"; }
            else if (ui.values[ 1 ] >= 12) { valString = ui.values[ 0 ] + " PM - " + i.values[ 1 ] - 12 + " PM"; }
        }
        else if (ui.values[ 0 ] > 12) { 
            if (ui.values[ 1 ] < 12) {  valString = ui.values[ 0 ] - 12 + " PM - " + i.values[ 1 ] + " AM"; }
            else if (ui.values[ 1 ] === 12) { valString = ui.values[ 0 ] - 12 + " PM - " + i.values[ 1 ] + " PM"; }
            else if (ui.values[ 1 ] >= 12) { valString = ui.values[ 0 ] - 12 + " PM - " + i.values[ 1 ] - 12 + " PM"; }
        }*/


        $( "#amount" ).val( ui.values[ 0 ] + " AM - " + ui.values[ 1 ] + " PM");
        //$( "#amount" ).val(valString);
      }
    });
    $( "#amount" ).val($( "#slider-range" ).slider( "values", 0 ) +
      " AM - " + $( "#slider-range" ).slider( "values", 1 ) + " PM");
  } );