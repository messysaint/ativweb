/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateModifyBusinessForm() {
	
	// Validate Business Name
	var businessname=document.forms["modifybusiness"]["businessname"].value;
	if (businessname==null || businessname=="") { // null or empty
		alert("Please enter Business Name");
		return false;
	}
		
	// Validate City / Town
	var citytown=document.forms["modifybusiness"]["citytown"].value;
	if (citytown==null || citytown=="") { // null or empty
		alert("Please enter City or Town");
		return false;
	}
		
	// Validate ZIP code
	var zipcode=document.forms["modifybusiness"]["zipcode"].value;
	if ( isNaN(zipcode) || zipcode.length < 4 ) { // not a number
		alert("Please enter ZIP Code");
		//alert( zipcode + zipcode.length );
		return false;
	}
	
	
	// Validate Email
	var email=document.forms["modifybusiness"]["email"].value;
	var atpos=email.indexOf("@");
	var dotpos=email.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length)
	  {
	  alert("Not a valid e-mail address");
	  return false;
	  }
	
	// Validate re-entered Email
	var reemail=document.forms["modifybusiness"]["reemail"].value;
	var atpos=reemail.indexOf("@");
	var dotpos=reemail.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=reemail.length)
	  {
	  alert("Not a valid re-entered e-mail address");
	  return false;
	  }
	
	// Compare email and Re-entered email
	if (email != reemail) { 
		alert("Email address and re-entered Email address is not the same");
		return false;
	}
	
	
	// Validate Business Description
	var businessdescription=document.forms["modifybusiness"]["businessdescription-text"].value;
	if (businessdescription.length < 10 ) { // null or empty
		alert("Please enter Business Description");
		return false;
	}
	
	
	// Validate business phone
	if ( document.forms["modifybusiness"]["phone"].value.search(/\d{3}\-\d{3}\-\d{4}/)==-1 ) { 
		alert("Please enter phone number formatted as xxx-xxx-xxxx");
		return false;
	}
	
	return confirm('Do you want to save modifications?');
	
}




















