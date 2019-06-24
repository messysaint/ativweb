<%--
 % Example for using the free http://captchas.net Webservice
 % Documentation see http://captchas.net/sample/jsp/
 --%>

 

<html>
 
<font face="Georgia, Arial, Garamond" size = "3">

<div align="center" >

<%

	session.setAttribute( "IVWEB_ISHUMAN", "NO" ); 

	session.setAttribute( "IVWEB_VIN", null ); 
	session.setAttribute( "IVWEB_YEAR", null  );
	session.setAttribute( "IVWEB_MAKE", null  );
	session.setAttribute( "IVWEB_MODEL", null  );
	session.setAttribute( "IVWEB_EMAIL", null  );
	session.setAttribute( "IVWEB_SECURITY_ANSWER", null  );
	session.setAttribute( "IVWEB_ZIPCODE", null  );

	String msg = "Logged off ...";
	out.println( msg );
%> 

</div>

</font>

</html>