// JavaScript Document

var family = 0;

$(function(){

	$( "#select-layer" ).hide();
	
	$( "#select-title" ).click( function() {
		family_click();
	} );
});

//	family site click
function family_click() {
	if( family == 1) {
		$( "#select-layer" ).hide();
		family = 0;
	} else {
		$( "#select-layer" ).show();
		family = 1;
	}
}
