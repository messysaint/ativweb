/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateMaintenanceForm() {
	
	// Validate dateofservice
	var dateofservice=document.forms["maintenanceForm"]["dateofservice"].value;
	if (dateofservice==null || dateofservice=="") { // null or empty
		alert("Please enter Date  of Service");
		return false;
	}
	
	// Validate cost of service
	var costofservice=document.forms["maintenanceForm"]["costofservice"].value;
	if (isNaN(costofservice)) { // null or empty
		alert("Please enter Cost of Service");
		return false;
	}
	
	// Validate current odometer value 
	var odometer=document.forms["maintenanceForm"]["odometer"].value;
	if (isNaN(odometer)) { // null or empty
		alert("Please enter current Odometer value");
		return false;
	}
	
	return confirm('Do you want to save this record?');
	
}




















