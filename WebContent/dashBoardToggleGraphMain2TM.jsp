<%@ page language="java" 
    import="java.util.*,java.io.IOException, com.abrstech.obd2.util.*, com.abrstech.sql.*, java.text.NumberFormat, java.math.BigDecimal"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@ page errorPage="showError.jsp" %>
   
   
<%

	String IVWEB_VIN = (String) session.getAttribute("IVWEB_VIN");

	if (IVWEB_VIN == null) {
		String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";
		response.sendRedirect(sessiontimeout);
	}
	
	Enumeration parameterList = request.getParameterNames();
	Enumeration parameterList2 = request.getParameterNames();
	//Enumeration parameterList3 = request.getParameterNames(); // for gauges
	//Enumeration parameterList4 = request.getParameterNames();
	
	String paramName = new String();
	String paramValue = new String();
			
	
	// used for toggle
	// preprare
	OBD2JSON json = new OBD2JSON();
			
	// START PROBLEM
	BigDecimal yAxisMinBIGDecimal = new BigDecimal( "0.00" );
	/*
	float yAxisMin = 0.00F;
	float tmp = 0.00F;
	
	int paramCtr4 = 0;
	for (; parameterList4.hasMoreElements(); parameterList4.nextElement()) {
		paramCtr4++;
		
		paramName = parameterList4.nextElement().toString().trim();
		paramValue = request.getParameter(paramName);
		
		if( paramCtr4 == 1) {
			tmp = json.getMinValue( paramValue );	
			yAxisMin = tmp;
		} else {				
			tmp = json.getMinValue( paramValue );
			if( tmp < yAxisMin) {
				yAxisMin = tmp;
			}
		}
									
	}
	
	
	// END PROBLEM
	yAxisMinBIGDecimal = json.rounded( new BigDecimal( yAxisMin) );
	*/
	
	
	
	int paramCtr = 0;
	for (; parameterList2.hasMoreElements(); parameterList2.nextElement()) {								
		paramCtr++;
	}
	
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>...</title>
	<link href="/ivweb/flot-0.8.1/flot/examples/examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="/ivweb/flot-0.8.1/flot/excanvas.min.js"></script><![endif]-->
	
	<script language="javascript" type="text/javascript" src="/ivweb/flot-0.8.1/flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/ivweb/flot-0.8.1/flot/jquery.flot.js"></script>
	
	<script type="text/javascript">
	
	
	
	$(function() { // BEGIN JAVASCRIPT FUNCTION

		var datasets = {
				
		<%// START
		
		// BEGIN Get Notification Parameter Names
		searchNotifications srchNotifyParameters = new searchNotifications();
		ArrayList notifyParams = srchNotifyParameters.getSearchNotifications( IVWEB_VIN );
		srchNotifyParameters.CloseDB();	
		// END  Get Notification Parameter Names
				
	
			int i = 0;
			while (parameterList.hasMoreElements()) {

				paramName = parameterList.nextElement().toString().trim();
				paramValue = request.getParameter(paramName);
				i++;

				if( notifyParams.contains( paramName) ) {
					
				// BEGIN build the data here
		%>
		
				"<%=paramName%>": {
					label: "<%=paramName%>",
					data:  <%=json.formatArrayJSON( paramValue ) %> 
				} <%= ( i < paramCtr ) ? "," : " " %>        
				
			
		<%
		
				} // end if
				
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
				+ val.label + "</label>" );
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
						min: <%=yAxisMinBIGDecimal%>,
						tickDecimals: 2
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