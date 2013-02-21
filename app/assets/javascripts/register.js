
$(document).ready(function(){ // When the document is ready
    $("select").change( //Have select objects on change 
	function() { // Execute this function
	    console.log(this.value); // Which logs the value selected
	    response = JSON.parse($.ajax({ // and parses json object into response from an ajax
		type: "GET", // get request
		url: "/user/description/" + this.value, // at this url
		async: false}).responseText); // converted to text

	    $("#description").html( // then replaces description's html with
		response.description); // the description
	    $("#presentor").html(
		response.presentor + ": </br>" + response.staken + "/" + response.slimit + " spots taken");
	    console.log(response);
	}
    )
});
