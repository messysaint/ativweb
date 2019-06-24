/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateMaintenanceForm() {
	
	// Validate ZIP code
	var zipcode=document.forms["maintenanceForm"]["zipcode"].value;
	if ( isNaN(zipcode) || zipcode.length != 5 ) { // not a number
		alert("Please enter ZIP Code");
		//alert( zipcode + zipcode.length );
		return false;
	}
	
	// Validate dateofservice
	var dateofservice=document.forms["maintenanceForm"]["dateofservice"].value;
	if (dateofservice==null || dateofservice=="") { // null or empty
		alert("Please enter Date  of Service");
		return false;
	}
	
	// Validate current odometer value 
	var odometer=document.forms["maintenanceForm"]["odometer"].value;
	if (isNaN(odometer)) { // null or empty
		alert("Please enter current Odometer value");
		return false;
	}
	if (odometer < 1) { // null or empty
		alert("Please enter current Odometer value");
		return false;
	}
	
	return confirm('Do you want to add to Marketplace?');
	
}




















