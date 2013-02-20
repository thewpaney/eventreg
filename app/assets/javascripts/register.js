
$(document).ready(function(){ // When the document is ready
    $("select").change(
	function() {
	    console.log(this.value);
	    response = $.ajax({
		type: "GET",
		url: "/user/description/" + this.value,
		async: false}).responseText;

	    $("#description").html(response);
	    console.log(response);
	}
    )
});
