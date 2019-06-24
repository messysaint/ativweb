/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateSearchBusinessForm() {
		
	// Validate City / Town
	// var citytown=document.forms["searchvehicle"]["citytown"].value;
	// if (citytown==null || citytown=="") { // null or empty
	//	alert("Please enter City or Town");
	//	return false;
	// }
		
	// Validate ZIP code
	// var zipcode=document.forms["searchvehicle"]["zipcode"].value;
	// if ( isNaN(zipcode) || zipcode.length != 5 ) { // not a number
	//	alert("Please enter ZIP Code");
	//	//alert( zipcode + zipcode.length );
	//	return false;
	// }
	
	
	// Validate Email
	var email=document.forms["searchmechanic"]["email"].value;
	var atpos=email.indexOf("@");
	var dotpos=email.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length)
	  {
	  alert("Not a valid e-mail address");
	  return false;
	  }
	
	
	
}




















