<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.abrstech.obd2.log.*, com.abrstech.obd2.security.*" 
%>

<%@ page errorPage="showError.jsp" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>OBDII logs for this VIN</title>

	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />	
		
</head>
<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

checkAuth check = new checkAuth();
		
if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";
	response.sendRedirect( sessiontimeout );
}
	
		
	String obd2code = request.getParameter( "obd2code" ).trim().toUpperCase(); 
	String car_years = request.getParameter( "car-years" ).trim().toUpperCase();
	String car_makes = request.getParameter( "car-makes" ).trim().toUpperCase();
	String car_models = request.getParameter( "car-models" ).trim().toUpperCase();
	String car_model_trims = request.getParameter( "car-model-trims" ).trim().toUpperCase();
	
	
	session.setAttribute( "SESSION_obd2code", obd2code );
	session.setAttribute( "SESSION_car-years", car_years );
	session.setAttribute( "SESSION_car-makes", car_makes );
	session.setAttribute( "SESSION_car-models", car_models );
	session.setAttribute( "SESSION_car-model-trims", car_model_trims );
	
    response.sendRedirect( "/ivweb/obd2PIDSearchTM.jsp" ); // set headers and send back to search page
    
    //response.setHeader("Refresh", "2; URL=/ivweb/selectVehicle.jsp");
    
%>


</font>

</body>
</html>