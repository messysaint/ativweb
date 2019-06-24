/*******************************************************************/
/* 
/* Validate Add New Vehicle Form
/*
/*******************************************************************/

function validateAddNewBusinessForm() {
	
	// Validate Referrer Email
	var email=document.forms["addnewbusiness"]["referreremail"].value;
	var atpos=email.indexOf("@");
	var dotpos=email.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length)
	  {
	  alert("Not a valid referrer e-mail address");
	  return false;
	  }
	
	// Validate Business Name
	var businessname=document.forms["addnewbusiness"]["businessname"].value;
	if (businessname==null || businessname=="") { // null or empty
		alert("Please enter Business Name");
		return false;
	}
		
	// Validate City / Town
	var citytown=document.forms["addnewbusiness"]["citytown"].value;
	if (citytown==null || citytown=="") { // null or empty
		alert("Please enter City or Town");
		return false;
	}
	
	// Validate State
	var state=document.forms["addnewbusiness"]["state"].value;
	if (state==null || state=="") { // null or empty
		alert("Please enter State");
		return false;
	}
	
	// Validate ZIP code
	var zipcode=document.forms["addnewbusiness"]["zipcode"].value;
	if ( zipcode.length < 3 ) { // not a number
		alert("Please enter ZIP Code");
		//alert( zipcode + zipcode.length );
		return false;
	}
	
	// Validate  "servicedzipcodes"
	var servicedzipcodes=document.forms["addnewbusiness"]["servicedzipcodes"].value;
	if ( servicedzipcodes.length < 3 ) { // not a number
		alert("Please enter Serviced ZIP Codes");
		//alert( zipcode + zipcode.length );
		return false;
	}
	
	// Validate Email
	var email=document.forms["addnewbusiness"]["email"].value;
	var atpos=email.indexOf("@");
	var dotpos=email.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length)
	  {
	  alert("Not a valid e-mail address");
	  return false;
	  }
	
	// Validate re-entered Email
	var reemail=document.forms["addnewbusiness"]["reemail"].value;
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
	var businessdescription=document.forms["addnewbusiness"]["businessdescription-text"].value;
	if (businessdescription.length < 10 ) { // null or empty
		alert("Please enter Business Description");
		return false;
	}
	
	
	// Validate business phone
	if ( document.forms["addnewbusiness"]["phone"].value.search(/\d{3}\-\d{3}\-\d{4}/)==-1 ) { 
		alert("Please enter phone number formatted as xxx-xxx-xxxx");
		return false;
	}
	
	// Validate Reminder Question
	var reminderquestion=document.forms["addnewbusiness"]["reminderquestion"].value;
	if (reminderquestion==null || reminderquestion=="") { // null or empty
		alert("Please enter reminder question");
		return false;
	}
	
	// Validate Reminder Answer
	var reminderanswer=document.forms["addnewbusiness"]["reminderanswer"].value;
	if (reminderanswer==null || reminderanswer=="") { // null or empty
		alert("Please enter reminder answer");
		return false;
	}
	
	return confirm('Do you want to save this record?');
	
}




















