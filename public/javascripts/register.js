$(document).ready(function(){ // When the document is ready
    $("select").change( //Have select objects, when they change, 
	function() { // Execute this function
//	    console.log(this.value); // Which logs the value selected
	    response = $.ajax({ // then parses json object into response from an ajax
		type: "POST", // post request
		url: "/user/description/" + this.value, // at this url
		async: false}).responseText; // converted to text
//	    console.log(response);
	    json = JSON.parse(response);
	    $("#description").html( // then replaces description's html with
		json.description); // the description
	    $("#presentor").html( //and the pages presenter with 
		json.presentor ); //the presenter

	}
    )
});
