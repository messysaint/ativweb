<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>

<%
	
 	String htmlToggleData = "[&nbsp;&nbsp;<A href=\"/ivweb/viewVin2TM.jsp\">Toggle Graph</A> &nbsp;&nbsp;] ";
	String htmlMultipleTripDetailsLink = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewMultipleTripDetailsTM.jsp\">Multiple Trip</A>&nbsp;&nbsp;]";
	String htmlSingleTripDetailsLink = "[&nbsp;&nbsp;<A href=\"/ivweb/providevinviewSingleTripDetailsTM.jsp\">Single Trip</A>&nbsp;&nbsp;]";
	String htmlNotificationRulesLink = "[&nbsp;&nbsp;<A href=\"/ivweb/notifyRulesTM.jsp\">Notification Rules</A>&nbsp;&nbsp;]";
	String htmlGaugeSelectionLink = "[&nbsp;&nbsp;<A href=\"/ivweb/gaugeSelectionTM.jsp\">Gauge Selection</A>&nbsp;&nbsp;]";
%>	
    


<font face="Georgia, Arial, Garamond" size="2">
&nbsp; &nbsp; <%=htmlNotificationRulesLink%>
&nbsp; &nbsp; <%=htmlGaugeSelectionLink%>
&nbsp; &nbsp; <%=htmlToggleData%> 
&nbsp; &nbsp; <%=htmlMultipleTripDetailsLink%>
&nbsp; &nbsp; <%=htmlSingleTripDetailsLink%>
</font>

<BR>
