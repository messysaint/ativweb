<%@ page language="java" 
    import="java.util.*,java.io.IOException, com.abrstech.obd2.util.*"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Flot Examples: Toggling Series</title>
	<link href="/ivweb/flot-0.8.1/flot/examples/examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="/ivweb/flot-0.8.1/flot/excanvas.min.js"></script><![endif]-->
	
	<script language="javascript" type="text/javascript" src="/ivweb/flot-0.8.1/flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/ivweb/flot-0.8.1/flot/jquery.flot.js"></script>
	
	<script type="text/javascript">
	
	
	
	$(function() { // BEGIN JAVASCRIPT FUNCTION

		var datasets = {
				
<%  // START

	String viewOtherData = "[&nbsp; <A href=\"/ivweb/providevinview.jsp\">View Other OBD2 Parameters</A> &nbsp;] ";
	String htmlMultipleTripDetailsLink = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewMultipleTripDetails.jsp\">Other Multiple Trip Data Averages</A>&nbsp;&nbsp;]";
	String htmlSingleTripDetailsLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewSingleTripDetails.jsp\">Single Trip Details</A>&nbsp;&nbsp;]";

	Enumeration parameterList = request.getParameterNames();	
	Enumeration parameterList2 = request.getParameterNames();
	
	String paramName = new String();
	String paramValue = new String();
	
	int paramCtr = 0;
	for(  ; parameterList2.hasMoreElements() ; parameterList2.nextElement()) {
		paramCtr++;
	}
	
	// preprare
	OBD2JSON json = new OBD2JSON();
	
	int i = 0;
	while( parameterList.hasMoreElements() ) {
	
		paramName = parameterList.nextElement().toString();   
		paramValue = request.getParameter( paramName );
		i++;
		
		// BEGIN build the data here
		%>
		
				"<%=paramName%>": {
					label: "<%=paramName%>",
					data:  <%=json.formatArrayJSON( paramValue ) %> 
				} <%= ( i < paramCtr ) ? "," : " " %>        
				
			
		<%
		// END build the data here
		
		//break; // get only first one
		
	}
	
	// END
%>

		}; // END JAVASCRIPT FUNCTION
	

		
		// hard-code color indices to prevent them from shifting as
		// countries are turned on/off

		var i = 0;
		$.each(datasets, function(key, val) {
			val.color = i;
			++i;
		});

		// insert checkboxes 
		var choiceContainer = $("#choices");
		$.each(datasets, function(key, val) {
			choiceContainer.append("<br><input type='checkbox' name='" + key +
				"' checked='checked' id='id" + key + "'></input>" +
				"<label for='id" + key + "'>"
				+ val.label + "</label> &nbsp; &nbsp;");
		});

		choiceContainer.find("input").click(plotAccordingToChoices);

		function plotAccordingToChoices() {

			var data = [];

			choiceContainer.find("input:checked").each(function () {
				var key = $(this).attr("name");
				if (key && datasets[key]) {
					data.push(datasets[key]);
				}
			});

			if (data.length > 0) {
				$.plot("#placeholder", data, {
					yaxis: {
						min: 0
					},
					xaxis: {
						tickDecimals: 0
					}
				});
			}
		}

		plotAccordingToChoices();

		// Add the Flot version string to the footer
		//$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
		
	});

	</script>
	
</head>
<body>

<font face="Georgia, Arial, Garamond" size="2">
<jsp:include page="dashBoard_SubMenuTM.jsp" />

	<div id="content">

		<div class="demo-container">			 
			<div id="placeholder" class="demo-placeholder" style="float:left; width:100%;"></div>
			<p id="choices" style="float:left; width:100%;"></p>
		</div>

		
	</div>


</font>

</body>
</html>