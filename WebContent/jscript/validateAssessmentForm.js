/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateAssessmentForm() {
	
	// Validate dateofservice
	var cityhighwaympg=document.forms["assessmentForm"]["cityhighwaympg"].value;
	if (isNaN(cityhighwaympg) ) { // null or empty
		alert("Please enter City/Highway Fuel Efficiency");
		return false;
	}
	
	// Validate cost of service
	var citympg=document.forms["assessmentForm"]["citympg"].value;
	if (isNaN(citympg)) { // null or empty
		alert("Please enter City Fuel Efficiency");
		return false;
	}
	
	// Validate current odometer value 
	var highwaympg=document.forms["assessmentForm"]["highwaympg"].value;
	if (isNaN(highwaympg)) { // null or empty
		alert("Please enter current Highway Fuel Efficiency");
		return false;
	}
	
	return confirm('Do you want to save this record?');
	
}




















