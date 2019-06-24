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
	<title>...</title>
	<link href="/ivweb/flot-0.8.1/flot/examples/examples.css" rel="stylesheet" type="text/css">
	<!--[if lte IE 8]><script language="javascript" type="text/javascript" src="/ivweb/flot-0.8.1/flot/excanvas.min.js"></script><![endif]-->
	
	<script language="javascript" type="text/javascript" src="/ivweb/flot-0.8.1/flot/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="/ivweb/flot-0.8.1/flot/jquery.flot.js"></script>
	
	<script type="text/javascript">
	
	
	
	$(function() { // BEGIN JAVASCRIPT FUNCTION

		var datasets = {
				
<%  // START

	String viewOtherData = "[&nbsp; <A href=\"/ivweb/providevinview.jsp\">View Other OBD2 Parameters</A> &nbsp;] ";
	String htmlMultipleTripDetailsLink = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewMultipleTripDetailsTM.jsp\">Multiple Trip Data Averages</A>&nbsp;&nbsp;]";
	String htmlSingleTripDetailsLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewSingleTripDetailsTM.jsp\">Single Trip Details</A>&nbsp;&nbsp;]";
	String htmlNotificationRulesLink   = "[&nbsp;&nbsp;<A href=\"/ivweb/notifyRulesTM.jsp\">Notification Rules</A>&nbsp;&nbsp;]";

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
	
		paramName = parameterList.nextElement().toString().trim();   
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
				+ val.label + "</label> &nbsp; &nbsp;" + "<a href=\"/ivweb/providevinanalyzeSingleTripDetails.jsp?param=1 | 2 | 3 | 4\">View</a>" );
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
	
	
	
	
	<style>
      body {
        text-align: center;
      }
      
      #g1, #g2, #g3, #g4, #g5, #g6 {
        width:200px; height:160px;
        display: inline-block;
        margin: 1em;
      }
          
      p {
        display: block;
        width: 450px;
        margin: 2em auto;
        text-align: left;
      }
    </style>
    
    <script src="/ivweb/justGage/resources/js/raphael.2.1.0.min.js"></script>
    <script src="/ivweb/justGage/resources/js/justgage.1.0.1.min.js"></script>
    <script>
      var g1, g2, g3, g4, g5, g6;
      
      window.onload = function(){
        var g1 = new JustGage({
          id: "g1", 
          value: 100, 
          min: 0,
          max: 100,
          title: "Param01",
          label: "label01",
          levelColorsGradient: false
        });
        
        var g2 = new JustGage({
          id: "g2", 
          value: 100,
          min: 0,
          max: 100,
          title: "Param02",
          label: "label02",
          levelColorsGradient: false
        });
        
        var g3 = new JustGage({
          id: "g3", 
          value: 100, 
          min: 0,
          max: 100,
          title: "Param03",
          label: "label03",
          levelColorsGradient: false
        });
      
        var g4 = new JustGage({
            id: "g4", 
            value: 100, 
            min: 0,
            max: 100,
            title: "Param04",
            label: "label04",
            levelColorsGradient: false
          });
        
        var g5 = new JustGage({
            id: "g5", 
            value: 100, 
            min: 0,
            max: 100,
            title: "Param05",
            label: "label05",
            levelColorsGradient: false
          });
        
        var g6 = new JustGage({
            id: "g6", 
            value: 100, 
            min: 0,
            max: 100,
            title: "Param06",
            label: "label06",
            levelColorsGradient: false
          });
        
        setInterval(function() {
          g1.refresh(getRandomInt(0, 100));
          g2.refresh(getRandomInt(0, 100));          
          g3.refresh(getRandomInt(0, 100));
          g4.refresh(getRandomInt(0, 100));
          g5.refresh(getRandomInt(0, 100));
          g6.refresh(getRandomInt(0, 100));
        }, 2500);
      };
    </script>
    
    
</head>
<body>

<font face="Georgia, Arial, Garamond" size="2">
 
&nbsp; &nbsp; <%=htmlMultipleTripDetailsLink%>
&nbsp; &nbsp; &nbsp; &nbsp; <%=htmlSingleTripDetailsLink%>
&nbsp; &nbsp; &nbsp; &nbsp; <%=htmlNotificationRulesLink%>

<table align="center" width="100%" border="0">
		<tr>
		<td> 			
  			<div id="g1"></div>
		</td>

		<td>			
  			<div id="g2"></div>
		</td>

		<td>			
  			<div id="g3"></div>
		</td>
		</tr>
	
		<tr>
		<td>			
  			<div id="g4"></div>
		</td>

		<td>						
  			<div id="g5"></div>
		</td>

		<td>						
  			<div id="g6"></div>
		</td>
		</tr>
	</table>
	
	<div id="content">

		<div class="demo-container">			 
			<div id="placeholder" class="demo-placeholder" style="float:left; width:100%;"></div>
			<p id="choices" style="float:left; width:100%;"></p>
		</div>

		
	</div>


</font>

</body>
</html>