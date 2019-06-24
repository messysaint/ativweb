<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*,java.text.Collator" 
%>

<%@ page errorPage="showError.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>OBDII logs for this VIN</title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />	
	<link type="text/css" href="/ivweb/datepicker/css/south-street/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
	<script type="text/javascript" src="/ivweb/datepicker/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/ivweb/datepicker/js/jquery-ui-1.8.22.custom.min.js"></script>

	<script type="text/javascript"	src="/ivweb/jscript/validateAddVehicleToMarketplaceForm.js"></script>
	
	<script>
	$(function() {
		$( "#datepicker" ).datepicker({ minDate: 1, maxDate: "+160D" });
	});
	</script>
	
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%

	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session

	String sessiontimeout = "/ivweb/z_securityquery.jsp";
	
	// check for session timed out
	if( IVWEB_VIN == null ) {
		response.sendRedirect( sessiontimeout );
	}
	
	String htmlbreak = "<br>";

	String errorMsg = "<H3>Your information does not match out record ...</H3>";

	String SESSIONVin = IVWEB_VIN;
	String SESSIONYear = (String) session.getAttribute( "IVWEB_YEAR" );
	String SESSIONMake = (String) session.getAttribute( "IVWEB_MAKE" );
	String SESSIONModel = (String) session.getAttribute( "IVWEB_MODEL" );
	String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
	String SESSIONAnswer = (String) session.getAttribute( "IVWEB_SECURITY_ANSWER" );
	String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );
	
	
	
	SESSIONEmail = SESSIONEmail.trim().toLowerCase();
	SESSIONAnswer = SESSIONAnswer.trim().toLowerCase();
	

%>

<table border="0">
  	 <tr>
   	    <th><h3>Posting to Marketplace</h3></th>
   	  </tr>  
</table>    
	
<form name="maintenanceForm" action="/ivweb/saveVehicleToMarketplace.jsp" onsubmit="return validateMaintenanceForm()" method="post">

<table border="0">

  <tr>
    <td>Current Vehicle Location ZIP Code: &nbsp;</td>
    <td><input type="text" name="zipcode"   maxlength="5" size="5" value="<%=SESSIONZipcode%>"/> </td>
  </tr>
  
  <tr>
      <td>Target Date of Service:</td>
      <td><input type="text" id="datepicker" name="dateofservice"  maxlength="10" size="10"></td>
      <td> &nbsp; </td>
      <td> &nbsp; </td>
  </tr>

  <tr>
      <td>Current Odometer Mileage: &nbsp; </td>
      <td> <input type="text" name="odometer"   maxlength="10" size="10" value="0"/> </td>
  </tr>

  <tr>
      <td> &nbsp; </td>
      <td> &nbsp; </td>
  </tr>


  <tr>
    <td>1. Engine System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-system-01"  value="Inspect belts">Inspect belts</td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-system-02"  value="Inspect hoses">Inspect hoses</td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-system-03"  value="Check for vacuum leaks and fuel leaks">Check for vacuum leaks and fuel leaks</td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-system-04"  value="Inspect ignition cables and engine wiring">Inspect ignition cables and engine wiring</td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-system-05"   value="Change engine oil and filter">Change engine oil and filter</td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-system-06"  value="Replace air filter">Replace air filter</td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-system-07"  value="Replace spark plugs">Replace spark plugs</td>
  </tr>
   
  <tr>
    <td> &nbsp; </td>
    <td><textarea name="engine-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
    <td>2. Fuel Supply System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="fuel-supply-system-01"  value="Replace fuel filter">Replace fuel filter </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="fuel-supply-system-02"  value="Inspect fuel lines and fuel tank mounts">Inspect fuel lines and fuel tank mounts</td>
  </tr>
 
  <tr>
    <td> &nbsp; </td>
    <td><textarea name="fuel-supply-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
    <td>3. Alternative Fuel Supply System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="alt-fuel-supply-system-01"  value="HHO Booster">HHO Booster</td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="alt-fuel-supply-system-02"  value="Water Injection">Water Injection</td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="alt-fuel-supply-system-03"  value="Methanol Water Injection">Methanol Water Injection</td>
  </tr>
  
  <tr>
    <td> &nbsp; </td>
    <td><textarea name="alt-fuel-supply-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
    <td>4. Drivetrain System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="drivetrain-system-01"  value="Inspect drive axles for damage or leakage">Inspect drive axles for damage or leakage </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="drivetrain-system-02"  value="Check transmission for leaks ">Check transmission for leaks  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="drivetrain-system-03"  value="Service transmission, fluid flush">Service transmission, fluid flush </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="drivetrain-system-04"  value="Service transfer case fluid">Service transfer case fluid </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="drivetrain-system-05"  value="Service differentials">Service differentials </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="drivetrain-system-06"  value="Transmission Fluid Service">Transmission Fluid Service </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><textarea name="drivetrain-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
    <td>5. Engine Cooling System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-cooling-system-01"  value="Check condition of hoses and belts">Check condition of hoses and belts </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-cooling-system-02"  value="Check for leaks">Check for leaks </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-cooling-system-03"  value="Flush cooling system">Flush cooling system </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="engine-cooling-system-04"  value="Cooling System Repair">Cooling System Repair </td>
  </tr>
  
  <tr>
    <td> &nbsp; </td>
    <td><textarea name="engine-cooling-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
    <td>6. Exhaust System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="exhaust-system-01"  value="Check for condition and leakage">Check for condition and leakage </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="exhaust-system-02"  value="Heat shields">Heat shields </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="exhaust-system-03"  value="Muffler and exhaust pipes">Muffler and exhaust pipes  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="exhaust-system-04"  value="Flex pipe">Flex pipe  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="exhaust-system-05"  value="Exhaust system mounts">Exhaust system mounts  </td>
  </tr>
  
  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="exhaust-system-06"  value="Exhaust and Muffler Repair or Replacement">Exhaust and Muffler Repair or Replacement </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><textarea name="exhaust-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
    <td>7. Braking System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="braking-system-01"  value="Check, adjust and test for proper operation">Check, adjust and test for proper operation </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="braking-system-02"  value="Inspect pad surfaces and rotor thickness">Inspect pad surfaces and rotor thickness  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="braking-system-03"  value="Inspect calipers and hoses">Inspect calipers and hoses  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="braking-system-04"  value="Inspect brake shoe thickness">Inspect brake shoe thickness </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="braking-system-05"  value="Inspect wheel cylinders and axle seals">Inspect wheel cylinders and axle seals  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="braking-system-06"  value="Check parking brake adjustment">Check parking brake adjustment  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="braking-system-07"  value="Test proper ABS system operation">Test proper ABS system operation  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="braking-system-08" value="Flush ABS brake system ">Flush ABS brake system  </td>
  </tr>

  
  <tr>
    <td> &nbsp; </td>
    <td><textarea name="braking-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
    <td>8. Electrical System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="electrical-system-01" value="Electrical System Diagnosis and Repair">Electrical System Diagnosis and Repair </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="electrical-system-02"  value="Alternators and starters">Alternators and starters </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="electrical-system-03"  value="Battery">Battery </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="electrical-system-04"  value="Headlight & Vehicle Bulbs">Headlight & Vehicle Bulbs </td>
  </tr>


  <tr>
    <td> &nbsp; </td>
    <td><textarea name="electrical-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
    <td>9. Steering System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="steering-system-01"  value="Check and verify proper operation">Check and verify proper operation </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="steering-system-02"  value="Inspect steering linkage and tie-rod ends">Inspect steering linkage and tie-rod ends  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="steering-system-03"  value="Inspect steering pump and hoses for leakage">Inspect steering pump and hoses for leakage  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="steering-system-04"  value="Inspect steering gear and boots">Inspect steering gear and boots  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="steering-system-05"  value="Flush power steering fluid">Flush power steering fluid  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><textarea name="steering-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
    <td>10. Tires/Suspension System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="tires-suspension-system-01"  value="Inspect tread depth">Inspect tread depth </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="tires-suspension-system-02"  value="Check for uneven wear patterns">Check for uneven wear patterns </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="tires-suspension-system-03"  value="Rotate and balance">Rotate and balance </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="tires-suspension-system-04"  value="Adjust tire pressure">Adjust tire pressure</td>
  </tr>
  
  <tr>
    <td> &nbsp; </td>
    <td><textarea name="tires-suspension-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
    <td>11. Heating/Air Conditioning System:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="heating-air-conditioning-system-01"  value="Check for proper operation of blowers">Check for proper operation of blowers </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="heating-air-conditioning-system-02"  value="Check for proper operation of AC and heater">Check for proper operation of AC and heater </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><textarea name="heating-air-conditioning-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>

  <tr>
    <td>12. Body:</td>
    <td>  </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="body-system-01"  value="Check for damaged or loose shields and shrouds">Check for damaged or loose shields and shrouds </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="body-system-02"  value="Check operation of seat belts and SRS system">Check operation of seat belts and SRS system </td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><INPUT type="checkbox" name="body-system-02"  value="Lubricate hinges and door latches">Lubricate hinges and door latches</td>
  </tr>

  <tr>
    <td> &nbsp; </td>
    <td><textarea name="body-system-text" rows="5" cols="50"> </textarea>  </td>
  </tr>


  <tr>
      <td> &nbsp; </td>
      <td>  &nbsp;</td>
  </tr>

  <tr>
      <td> &nbsp; </td>
      <td><INPUT type="submit" value="Submit to Marketplace"></td>
  </tr>

</table>


</form>


</font>

</body>
</html>