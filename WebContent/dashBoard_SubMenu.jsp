<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>

<%
	
	String modifyVehicleInfo = "[&nbsp;&nbsp;<A href=\"/ivweb/modifyVehicleInfo.jsp\">Modify Info</A>&nbsp;&nbsp;]";
 	String htmlToggleData = "[&nbsp;&nbsp;<A href=\"/ivweb/viewVin2.jsp\">Toggle Graph</A> &nbsp;&nbsp;] ";
	String htmlMultipleTripDetailsLink = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewMultipleTripDetails.jsp\">Multiple Trip</A>&nbsp;&nbsp;]";
	String htmlSingleTripDetailsLink = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewSingleTripDetails.jsp\">Single Trip</A>&nbsp;&nbsp;]";
	String htmlNotificationRulesLink = "[&nbsp;&nbsp;<A href=\"/ivweb/notifyRules.jsp\">Notification Rules</A>&nbsp;&nbsp;]";
	String htmlGaugeSelectionLink = "[&nbsp;&nbsp;<A href=\"/ivweb/gaugeSelection.jsp\">Gauge Selection</A>&nbsp;&nbsp;]";
	String htmlDialSelectionLink = "[&nbsp;&nbsp;<A href=\"/ivweb/viewVin.jsp\">Dial Meters</A>&nbsp;&nbsp;]";
%>	
    


<font face="Georgia, Arial, Garamond" size="2">
&nbsp; &nbsp; <%=htmlNotificationRulesLink%>
&nbsp; &nbsp; <%=htmlGaugeSelectionLink%>
&nbsp; &nbsp; <%=htmlDialSelectionLink%>
&nbsp; &nbsp; <%=htmlToggleData%> 
&nbsp; &nbsp; <%=htmlMultipleTripDetailsLink%>
&nbsp; &nbsp; <%=htmlSingleTripDetailsLink%>
&nbsp; &nbsp; <%=modifyVehicleInfo%>
</font>

<BR>

