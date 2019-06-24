/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateModifyVinForm() {
	
	// Validate ZIP code
	var zipcode=document.forms["updatevehicle"]["zipcode"].value;
	if ( isNaN(zipcode) || zipcode.length < 4 ) { // not a number
		alert("Please enter ZIP Code");
		//alert( zipcode + zipcode.length );
		return false;
	}
		
	// Validate Email
	var email=document.forms["updatevehicle"]["email"].value;
	var atpos=email.indexOf("@");
	var dotpos=email.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length)
	  {
	  alert("Not a valid e-mail address");
	  return false;
	  }
	
	// Validate re-entered Email
	var reemail=document.forms["updatevehicle"]["reemail"].value;
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
	
	// Validate Reminder Question
	var reminderquestion=document.forms["updatevehicle"]["reminderquestion"].value;
	if (reminderquestion==null || reminderquestion=="") { // null or empty
		alert("Please enter reminder question");
		return false;
	}
	
	// Validate Reminder Answer
	var reminderanswer=document.forms["updatevehicle"]["reminderanswer"].value;
	if (reminderanswer==null || reminderanswer=="") { // null or empty
		alert("Please enter reminder answer");
		return false;
	}
	
}




















