<%@ page language="java" 
    import="com.abrstech.obd2.log.FindVin, com.abrstech.sql.*,com.abrstech.obd2.security.*"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
   
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   

<html>
<head>
<title>OBDII logs for this VIN</title>
</head>

<body>



<font face="Georgia, Arial, Garamond" size = "2">

<%
// get System Date



String sessiontimeout = "/ivweb/z_securityquery.jsp";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} 

String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
String SESSIONYear = (String) session.getAttribute( "IVWEB_YEAR" );
String SESSIONMake = (String) session.getAttribute( "IVWEB_MAKE" );
String SESSIONModel = (String) session.getAttribute( "IVWEB_MODEL" );
String SESSIONEmail = (String) session.getAttribute( "IVWEB_EMAIL" );
String SESSIONAnswer = (String) session.getAttribute( "IVWEB_SECURITY_ANSWER" );
String SESSIONZipcode = (String) session.getAttribute( "IVWEB_ZIPCODE" );
 

if( IVWEB_VIN == null ) {
	String errorMsg = "<H3>No vehicle has been selected yet ...</H3>";
	String redirectMsg = "<br>Redirecting to Select Vehicle ...";
	
	out.println( errorMsg );
	response.setHeader("Refresh", "2; url=/ivweb/addVin.jsp");
	
} else {

	
	int i = 0;
	
	//String listoFTrustedMechanics = "[&nbsp; <A href=\"/ivweb/myAutoMechanicAvailableList.jsp\">View List of Trusted Mechanics</A> &nbsp;] ";
	
	
%>

<table border="0">
 <tr>
    <th> [&nbsp; <A href="/ivweb/myAutoMechanicAvailableList.jsp">Servicing your ZIP</A> &nbsp;] &nbsp;&nbsp; [&nbsp; <A href="/ivweb/myAutoMechanicAvailableListOtherZIP.jsp">Servicing other ZIP Codes</A> &nbsp;] &nbsp;&nbsp; [&nbsp; <A href="/ivweb/myAutoMechanicAvailableListOtherEmail.jsp">Use Mechanic Email Address</A> &nbsp;]</th>
 </tr>
 <tr>
    <th>  </th>
 </tr>
</table>

<form name="ClearTrustedMechanics" action="/ivweb/clearTrustedMechanics.jsp" onsubmit="return validateClearTrustedMechanics()" method="post">
<table border="0">
  <tr>
      <td> <INPUT type="submit" value="Clear My List Of Trusted Mechanics"> </td>
      <td> </td>
  </tr> 
</table>
</form>

<sql:setDataSource dataSource="jdbc/abrstech_obd2db" />

<sql:query var="rs">    
	SELECT MYMECHANICS.seqno as mymechid, MYMECHANICS.auto_business_seqno, 
	ALLMECHANICS.seqno, ALLMECHANICS.country, ALLMECHANICS.businessname, ALLMECHANICS.citytown, ALLMECHANICS.zipcode, ALLMECHANICS.servicedzipcodes, ALLMECHANICS.email, ALLMECHANICS.businessdescription, ALLMECHANICS.website, ALLMECHANICS.phone   
	FROM abrstech_obd2db.car_mechanic_tbl as MYMECHANICS 
	JOIN (abrstech_obd2db.auto_business_tbl as ALLMECHANICS)
	ON (ALLMECHANICS.seqno=MYMECHANICS.auto_business_seqno)
	WHERE MYMECHANICS.vin="<%=IVWEB_VIN%>" ;  
</sql:query>

<c:forEach var="row" items="${rs.rows}">
	 <br><br> 
	 <%=++i%>. &nbsp;
     ${row.businessname} &nbsp; <br>
	 ${row.citytown} &nbsp;  ${row.zipcode}; <br>
	 ${row.country} &nbsp; <br>
	 ${row.website} &nbsp; <br>
	 Email: ${row.email} &nbsp; Phone: ${row.phone} &nbsp; <br>
	 Serviced Zip Codes: ${row.servicedzipcodes} &nbsp; <br>
	 Description: ${row.businessdescription} &nbsp;  <br>
     
</c:forEach>



<%
}
%>

</font>

</body>

</html>