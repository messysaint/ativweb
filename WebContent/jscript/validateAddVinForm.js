/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateAddNewVehicleForm() {
	
	// Validate ZIP code
	var zipcode=document.forms["addnewvehicle"]["zipcode"].value;
	if ( zipcode.length < 3 ) { // not a number
		alert("Please enter ZIP Code");
		//alert( zipcode + zipcode.length );
		return false;
	}
	
	// Validate VIN
	var vin=document.forms["addnewvehicle"]["vin"].value;
	if (vin==null || vin=="") { // null or empty
		alert("Please enter VIN");
		return false;
	}
	if (vin.length != 17) { // null or empty
		alert("VIN should be 17 characters long");
		return false;
	}
	
	// Validate re-enter VIN
	var revin=document.forms["addnewvehicle"]["revin"].value;
	if (revin==null || revin=="") { // null or empty
		alert("Please re-enter VIN");
		return false;
	}
	if (revin.length != 17) { // null or empty
		alert("Re-entered VIN should be 17 characters long");
		return false;
	}

	// Compare VIN and Re-entered VIN
	if (vin != revin) { 
		alert("VIN and re-entered VIN is not the same");
		return false;
	}
	
	// Validate Year
	var caryears=document.forms["addnewvehicle"]["car-years"].value;
	if (caryears.length != 4) { // null or empty
		alert("Please select Year");
		return false;
	}
	
	// Validate Make
	var carmakes=document.forms["addnewvehicle"]["car-makes"].value;
	if (carmakes==null || carmakes=="---" || carmakes=="") { // null or empty or "---"
		alert("Please select Make");
		return false;
	}
	
	// No need to validate Model and Trim because these automatically populate default values
	
	// Validate Email
	var email=document.forms["addnewvehicle"]["email"].value;
	var atpos=email.indexOf("@");
	var dotpos=email.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length)
	  {
	  alert("Not a valid e-mail address");
	  return false;
	  }
	
	// Validate re-entered Email
	var reemail=document.forms["addnewvehicle"]["reemail"].value;
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
	var reminderquestion=document.forms["addnewvehicle"]["reminderquestion"].value;
	if (reminderquestion==null || reminderquestion=="") { // null or empty
		alert("Please enter reminder question");
		return false;
	}
	
	// Validate Reminder Answer
	var reminderanswer=document.forms["addnewvehicle"]["reminderanswer"].value;
	if (reminderanswer==null || reminderanswer=="") { // null or empty
		alert("Please enter reminder answer");
		return false;
	}
	
}




















