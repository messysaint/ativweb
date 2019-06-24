/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateSearchVehicleOwnerForm() {
		
	
	
	// Validate Email
	var email=document.forms["searchvehicle"]["email"].value;
	var atpos=email.indexOf("@");
	var dotpos=email.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length)
	  {
	  alert("Not a valid e-mail address");
	  return false;
	  }
	
	
	
}




















