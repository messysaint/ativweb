/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateOBD2CodeDescription() {
	
	// Validate OBD2 Code
	var description=document.forms["addobd2code"]["description"].value;
	if (description==null || description=="") { // null or empty
		alert("Please enter OBD2 Code Description");
		return false;
	}
	
	return confirm('Do you want to save this new code?');
	
	
}




















