/*******************************************************************/
/* 
/* Validate Vehicle Form
/*
/*******************************************************************/

function validateVinForm() {
	
	// Validate VIN
	var vin=document.forms["searchvehicle"]["vin"].value;
	if (vin==null || vin=="") { // null or empty
		alert("Please enter VIN");
		return false;
	}
	
	
	// Validate Year
	var caryears=document.forms["searchvehicle"]["car-years"].value;
	if (caryears.length != 4) { // null or empty
		alert("Please select Year");
		return false;
	}
	
	// Validate Make
	var carmakes=document.forms["searchvehicle"]["car-makes"].value;
	if (carmakes==null || carmakes=="---" || carmakes=="") { // null or empty or "---"
		alert("Please select Make");
		return false;
	}
	
	// No need to validate Model and Trim because these automatically populate default values
	
	
}




















