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

			// get Gauges
	VINGauges gauges = new VINGauges();
	gauges.getMyGauges(IVWEB_VIN);
	gauges.CloseDB();

	String Gauge01 = gauges.getGauge01();   
	String Gauge02 = gauges.getGauge02();
	String Gauge03 = gauges.getGauge03();
	String Gauge04 = gauges.getGauge04();
	String Gauge05 = gauges.getGauge05();
	String Gauge06 = gauges.getGauge06();
		
	
	Enumeration parameterList3 = request.getParameterNames(); // for gauges

	
	String paramName = new String();
	String paramValue = new String();
			
	// used for gauges		
	BigDecimal[] min = new BigDecimal[6];
	BigDecimal[] max = new BigDecimal[6];
	BigDecimal[] val = new BigDecimal[6];
	BigDecimal[] mov = new BigDecimal[6];
	
	// init arrays
	float num = 0.00F;
	for( int i = 0 ; i < min.length ; i++ ) {
		min[i] = new BigDecimal( num );
		max[i] = new BigDecimal( num );
		val[i] = new BigDecimal( num );
		mov[i] = new BigDecimal( num );
	}
	
	// prepare	
	float movFactor = 0.02F;
	int minMaxValCtr = 0;
	while (parameterList3.hasMoreElements()) {
		
		paramName = parameterList3.nextElement().toString().trim();
		paramValue = request.getParameter(paramName);
		
		if( paramName.equalsIgnoreCase( Gauge01 ) ) {
			OBD2Gauges obd2 = new OBD2Gauges();
			obd2.parse( paramValue );
			min[0] = obd2.getBigDecimalMinValue(); //obd2.getMinValue();
			max[0] = obd2.getBigDecimalMaxValue(); //obd2.getMaxValue();
			val[0] = obd2.getBigDecimalAveValue(); //obd2.getAveValue();
			mov[0] = obd2.rounded( new BigDecimal(obd2.getAveValue() - ( obd2.getAveValue() * movFactor )) ); //obd2.getAveValue() - ( obd2.getAveValue() * movFactor );
		} else if( paramName.equalsIgnoreCase( Gauge02 ) ) {
			OBD2Gauges obd2 = new OBD2Gauges();
			obd2.parse( paramValue );
			min[1] = obd2.getBigDecimalMinValue(); //obd2.getMinValue();
			max[1] = obd2.getBigDecimalMaxValue(); //obd2.getMaxValue();
			val[1] = obd2.getBigDecimalAveValue(); //obd2.getAveValue();
			mov[1] = obd2.rounded( new BigDecimal(obd2.getAveValue() - ( obd2.getAveValue() * movFactor )) ); //obd2.getAveValue() - ( obd2.getAveValue() * movFactor );
		} else if( paramName.equalsIgnoreCase( Gauge03 ) ) {
			OBD2Gauges obd2 = new OBD2Gauges();
			obd2.parse( paramValue );
			min[2] = obd2.getBigDecimalMinValue(); //obd2.getMinValue();
			max[2] = obd2.getBigDecimalMaxValue(); //obd2.getMaxValue();
			val[2] = obd2.getBigDecimalAveValue(); //obd2.getAveValue();
			mov[2] = obd2.rounded( new BigDecimal(obd2.getAveValue() - ( obd2.getAveValue() * movFactor )) ); //obd2.getAveValue() - ( obd2.getAveValue() * movFactor );
		} else if( paramName.equalsIgnoreCase( Gauge04 ) ) {
			OBD2Gauges obd2 = new OBD2Gauges();
			obd2.parse( paramValue );
			min[3] = obd2.getBigDecimalMinValue(); //obd2.getMinValue();
			max[3] = obd2.getBigDecimalMaxValue(); //obd2.getMaxValue();
			val[3] = obd2.getBigDecimalAveValue(); //obd2.getAveValue();
			mov[3] = obd2.rounded( new BigDecimal(obd2.getAveValue() - ( obd2.getAveValue() * movFactor )) ); //obd2.getAveValue() - ( obd2.getAveValue() * movFactor );
		} else if( paramName.equalsIgnoreCase( Gauge05 ) ) {
			OBD2Gauges obd2 = new OBD2Gauges();
			obd2.parse( paramValue );
			min[4] = obd2.getBigDecimalMinValue(); //obd2.getMinValue();
			max[4] = obd2.getBigDecimalMaxValue(); //obd2.getMaxValue();
			val[4] = obd2.getBigDecimalAveValue(); //obd2.getAveValue();
			mov[4] = obd2.rounded( new BigDecimal(obd2.getAveValue() - ( obd2.getAveValue() * movFactor )) ); //obd2.getAveValue() - ( obd2.getAveValue() * movFactor );
		} else if( paramName.equalsIgnoreCase( Gauge06 ) ) {
			OBD2Gauges obd2 = new OBD2Gauges();
			obd2.parse( paramValue );
			min[5] = obd2.getBigDecimalMinValue(); //obd2.getMinValue();
			max[5] = obd2.getBigDecimalMaxValue(); //obd2.getMaxValue();
			val[5] = obd2.getBigDecimalAveValue(); //obd2.getAveValue();
			mov[5] = obd2.rounded( new BigDecimal(obd2.getAveValue() - ( obd2.getAveValue() * movFactor )) ); //obd2.getAveValue() - ( obd2.getAveValue() * movFactor );
		}
		
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
	

	
	
	<style>
      
      
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
        value: <%=val[0]%>,
        min: <%=min[0]%>,
        max: <%=max[0]%>,
        title: "<%=Gauge01.length() > 25 ? Gauge01.subSequence( 0, 24): Gauge01%>",
        label: "Gauge01",
        levelColorsGradient: false
      });
      
      var g2 = new JustGage({
        id: "g2", 
        value: <%=val[1]%>,
        min: <%=min[1]%>,
        max: <%=max[1]%>,
        title: "<%=Gauge02.length() > 25 ? Gauge02.subSequence( 0, 24): Gauge02%>",
        label: "Gauge02",
        levelColorsGradient: false
      });
      
      var g3 = new JustGage({
        id: "g3", 
        value: <%=val[2]%>,
        min: <%=min[2]%>,
        max: <%=max[2]%>,
        title: "<%=Gauge03.length() > 25 ? Gauge03.subSequence( 0, 24): Gauge03%>",
        label: "Gauge03",
        levelColorsGradient: false
      });
    
      var g4 = new JustGage({
          id: "g4", 
          value: <%=val[3]%>,
          min: <%=min[3]%>,
          max: <%=max[3]%>,
          title: "<%=Gauge04.length() > 25 ? Gauge04.subSequence( 0, 24): Gauge04%>",
          label: "Gauge04",
          levelColorsGradient: false
        });
      
      var g5 = new JustGage({
          id: "g5", 
          value: <%=val[4]%>,
          min: <%=min[4]%>,
          max: <%=max[4]%>,
          title: "<%=Gauge05.length() > 25 ? Gauge05.subSequence( 0, 24): Gauge05%>",
          label: "Gauge05",
          levelColorsGradient: false
        });
      
      var g6 = new JustGage({
          id: "g6", 
          value: <%=val[5]%>,
          min: <%=min[5]%>,
          max: <%=max[5]%>,
          title: "<%=Gauge06.length() > 25 ? Gauge06.subSequence( 0, 24): Gauge06%>",
          label: "Gauge06",
          levelColorsGradient: false
        });
      
      setInterval(function() {
        g1.refresh(getRandomInt(<%=Gauge01.equalsIgnoreCase("NONE")  ? 0 : mov[0]%>, <%=Gauge01.equalsIgnoreCase("NONE")  ? 1 : val[0]%>));
        g2.refresh(getRandomInt(<%=Gauge02.equalsIgnoreCase("NONE")  ? 0 : mov[1]%>, <%=Gauge02.equalsIgnoreCase("NONE")  ? 1 : val[1]%>));          
        g3.refresh(getRandomInt(<%=Gauge03.equalsIgnoreCase("NONE")  ? 0 : mov[2]%>, <%=Gauge03.equalsIgnoreCase("NONE")  ? 1 : val[2]%>));
        g4.refresh(getRandomInt(<%=Gauge04.equalsIgnoreCase("NONE")  ? 0 : mov[3]%>, <%=Gauge04.equalsIgnoreCase("NONE")  ? 1 : val[3]%>));
        g5.refresh(getRandomInt(<%=Gauge05.equalsIgnoreCase("NONE")  ? 0 : mov[4]%>, <%=Gauge05.equalsIgnoreCase("NONE")  ? 1 : val[4]%>));
        g6.refresh(getRandomInt(<%=Gauge06.equalsIgnoreCase("NONE")  ? 0 : mov[5]%>, <%=Gauge06.equalsIgnoreCase("NONE")  ? 1 : val[5]%>));
      }, 2500);
    };
    </script>
    
    
</head>
<body>

<font face="Georgia, Arial, Garamond" size="2">
 
<jsp:include page="dashBoard_SubMenuTM.jsp" />

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


</font>

</body>
</html>