<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*,com.abrstech.sql.*,com.abrstech.obd2.security.*,com.abrstech.obd2.util.*"
%>

<%@ page errorPage="showError.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Save New Maintenance to DB</title>
<script type="text/javascript"
	src="/ivweb/jscript/validateAddMaintenanceForm.js"></script>
</head>
<body>

	<font face="Georgia, Arial, Garamond" size="2"> <%
 	
	String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";
	
 	String notSaved = "<h3>Selected gauges were not saved.</h3>";
 	String message1 = "<h3>Selected gauges were saved to the database.</h3>";

 	checkAuth check = new checkAuth();

 	String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );
 	String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); 

 	if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
 		response.sendRedirect( sessiontimeout );
 	} else { 
 		
 		
 		// check for session timed out
 		if( IVWEB_VIN == null ) {
 			response.sendRedirect( sessiontimeout );
 		}
		
 		String gauge01 = request.getParameter("gauge01");
 		String gauge02 = request.getParameter("gauge02");
 		String gauge03 = request.getParameter("gauge03");
 		String gauge04 = request.getParameter("gauge04");
 		String gauge05 = request.getParameter("gauge05");
 		String gauge06 = request.getParameter("gauge06");
 		
 		
 		saveUpdateGauges saveGauge = new saveUpdateGauges();  
 		boolean saveOk = saveGauge.WriteToDB( IVWEB_VIN, gauge01, gauge02, gauge03, gauge04, gauge05, gauge06); 
 		saveGauge.CloseDB();

 		
 		if (!saveOk) {
 			out.println(notSaved);
 		} else {
 			// forward to view data
 			String viewGraph = "/ivweb/viewVinTM.jsp";
 			response.sendRedirect( viewGraph );
 		}

 	}
 %>


	</font>

</body>
</html>