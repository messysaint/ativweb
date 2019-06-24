/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateOBD2Code() {
	
	// Validate OBD2 Code
	var reminderanswer=document.forms["searchobd2"]["obd2code"].value;
	if (reminderanswer==null || reminderanswer=="") { // null or empty
		alert("Please enter OBD2 Code");
		return false;
	}
	
	// Validate Year
	var caryears=document.forms["searchobd2"]["car-years"].value;
	if (caryears.length != 4) { // null or empty
		alert("Please select Year");
		return false;
	}
	
	// Validate Make
	var carmakes=document.forms["searchobd2"]["car-makes"].value;
	if (carmakes==null || carmakes=="---" || carmakes=="") { // null or empty or "---"
		alert("Please select Make");
		return false;
	}
	
	// No need to validate Model and Trim because these automatically populate default values
	
	
}




















