/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateOfferForm() {
	
	
	// Validate cost of service
	var costofservice=document.forms["makeoffer"]["estimatedcost"].value;
	if (isNaN(costofservice)) { // null or empty
		alert("Please enter estimated Cost of Service");
		return false;
	}

	if ( costofservice < 1 ) { // null or empty
		alert("Please enter estimated Cost of Service");
		return false;
	}
	
	var notes=document.forms["makeoffer"]["notes"].value;
	if (notes==null || notes=="") { // null or empty
		alert("Please enter a note for the vehicle owner");
		return false;
	}
	
	return confirm('Do you want to send this offer?');
	
}




















