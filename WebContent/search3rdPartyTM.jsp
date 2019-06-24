<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import = "com.abrstech.obd2.security.*"
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>debug</title>

	<script type="text/javascript" src="/ivweb/jscript/validateMessageForm.js"></script>
</head>
<body>
<font face="Georgia, Arial, Garamond" size = "2">

 
<% // declare variables
   
String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";

//String loginAutoBusiness = "&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; <A href=\"/ivweb/marketPlaceMoreDetailsTM.jsp\">My Service Locations</A> &nbsp;]";
//String loginAutoOwner = "&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; <A href=\"/ivweb/marketPlaceVehicleOwner.jsp\">Vehicle Owner</A> &nbsp;]";

checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} 
   
String IVWEB_VIN = (String) session.getAttribute( "IVWEB_VIN" ); // retrieve IVWEB_VIN from HTTP Session
Integer IVWEB_SEQNO = (Integer) session.getAttribute( "IVWEB_SEQNO" ); // retrieve IVWEB_VIN from HTTP Session
String SESSIONBusinessname = (String) session.getAttribute( "IVWEB_BUSINESSNAME" );

// check for session timed out
if( IVWEB_SEQNO == null ) {
	String errorMsg = "<H3>No Trusted Mechanic has been selected yet ...</H3>";
	//String redirectMsg = "<br>Redirecting to Select Trusted Mechanic...";
	
	out.println( errorMsg );
	
} else {
	
%>
 
 <BR><BR>

<table border="0" align="center" cellpadding="0" width="50%" >
  
   <tr>
    <th>

		<div>    
		<script>
		  (function() {
		    var cx = '012280299325998076195:yag95vi9sdo';
		    var gcse = document.createElement('script');
		    gcse.type = 'text/javascript';
		    gcse.async = true;
		    gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
		        '//www.google.com/cse/cse.js?cx=' + cx;
		    var s = document.getElementsByTagName('script')[0];
		    s.parentNode.insertBefore(gcse, s);
		  })();
		</script>
		<gcse:search></gcse:search>
		</div>                                
    
    </th>    
  </tr>
</table>


<BR><BR>


<div>
<table  height="38" border="0" align="center" cellpadding="0" cellspacing="0" width="50%">
<form method=POST accept-charset="UTF-8" action='http://ixquick.com/do/search' name="searchsys" id="searchsys" onSubmit="javascript:document.searchsys.query.value=document.searchsys.keyword.value;" style="padding: 0px; margin:0px;">
<tr>
<td height="38" style="height:38px;">
<input name=query type=hidden>
<input name=keyword class="width_update_class" type=text style="width : 260px; _height : 23px;   font : 14px verdana, arial, sans-serif; padding : 0px 6px; *padding : 1px 6px 6px; padding-top:1px !important; padding-bottom:1px !important;outline: none; background:white;">
<input type=hidden name=frm value=sb>
<input type=hidden name=cmd value="process_search">
<input name=language type=hidden value=english_uk >
</td>
<td height="38" style="height:38px;margin:0;padding:0;">
<input type=submit value="IXquick Search" style="margin: 0 5px 0 5px;">
</td>
</tr> 
</form>
</table> <!--LBS--><!--LBE-->
</div>  


<BR><BR>


<div>
<form method="get" action="http://search.yahoo.com/search">
<table border="0" align="center" cellpadding="0" width="50%">
<tr>
<td>
<input type="text"   name="p" size="25" maxlength="255" value="" />
<input type="submit" value="Yahoo! Search" />
</td>
</tr>
</table>
</form>
</div>

<BR><BR>


<div>
<form method="get" action="http://www.bing.com/search">
<table border="0" align="center" cellpadding="0" width="50%">
<tr>
<td>
<input type="text"   name="q" size="25" maxlength="255" value="" />
<input type="submit" value="Bing Search" />
</td>
</tr>
</table>
</form>
</div>

<% 
	}
%>

</font>

</body>
</html>