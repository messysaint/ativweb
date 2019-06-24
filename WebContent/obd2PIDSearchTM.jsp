<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import = "com.abrstech.obd2.security.*"
%>

<%@ page errorPage="showError.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provide VIN</title>

<script type="text/javascript" src="http://www.carqueryapi.com/js/jquery.min.js"></script>
<script type="text/javascript" src="http://www.carqueryapi.com/js/carquery.0.3.3.js"></script>

<script type="text/javascript" src="/ivweb/jscript/validateOBD2Code.js"></script>

<script type="text/javascript">
$(document).ready(
function()
{
     //Create a variable for the CarQuery object.  You can call it whatever you like.
     var carquery = new CarQuery();

     //Run the carquery init function to get things started:
     carquery.init();

     //Optionally, you can pre-select a vehicle by passing year / make / model / trim to the init function:
     //carquery.init('2000', 'dodge', 'Viper', 11636);

     //Optional: Pass sold_in_us:true to the setFilters method to show only US models.
     carquery.setFilters( {sold_in_us:false} );

     //Optional: initialize the year, make, model, and trim drop downs by providing their element IDs
     carquery.initYearMakeModelTrim('car-years', 'car-makes', 'car-models', 'car-model-trims');

     //Optional: set the onclick event for a button to show car data.
     $('#cq-show-data').click(  function(){ carquery.populateCarData('car-model-data'); } );

     //Optional: initialize the make, model, trim lists by providing their element IDs.
     carquery.initMakeModelTrimList('make-list', 'model-list', 'trim-list', 'trim-data-list');

     //Optional: set minimum and/or maximum year options.
     carquery.year_select_min=1940;
     carquery.year_select_max=2020;

     //Optional: initialize search interface elements.
     //The IDs provided below are the IDs of the text and select inputs that will be used to set the search criteria.
     //All values are optional, and will be set to the default values provided below if not specified.
     var searchArgs =
     ({
         body_id:                       "cq-body"
        ,default_search_text:           "Keyword Search"
        ,doors_id:                      "cq-doors"
        ,drive_id:                      "cq-drive"
        ,engine_position_id:            "cq-engine-position"
        ,engine_type_id:                "cq-engine-type"
        ,fuel_type_id:                  "cq-fuel-type"
        ,min_cylinders_id:              "cq-min-cylinders"
        ,min_mpg_hwy_id:                "cq-min-mpg-hwy"
        ,min_power_id:                  "cq-min-power"
        ,min_top_speed_id:              "cq-min-top-speed"
        ,min_torque_id:                 "cq-min-torque"
        ,min_weight_id:                 "cq-min-weight"
        ,min_year_id:                   "cq-min-year"
        ,max_cylinders_id:              "cq-max-cylinders"
        ,max_mpg_hwy_id:                "cq-max-mpg-hwy"
        ,max_power_id:                  "cq-max-power"
        ,max_top_speed_id:              "cq-max-top-speed"
        ,max_weight_id:                 "cq-max-weight"
        ,max_year_id:                   "cq-max-year"
        ,search_controls_id:            "cq-search-controls"
        ,search_input_id:               "cq-search-input"
        ,search_results_id:             "cq-search-results"
        ,search_result_id:              "cq-search-result"
        ,seats_id:                      "cq-seats"
        ,sold_in_us_id:                 "cq-sold-in-us"
     });
     carquery.initSearchInterface(searchArgs);

     //If creating a search interface, set onclick event for the search button.  Make sure the ID used matches your search button ID.
     $('#cq-search-btn').click( function(){ carquery.search(); } );
});
</script>

</head>

<body>

<font face="Georgia, Arial, Garamond" size = "2">

<%

String sessiontimeout = "/ivweb/z_securityqueryTM.jsp";


checkAuth check = new checkAuth();

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );
Integer IVWEB_SEQNO = (Integer) session.getAttribute( "IVWEB_SEQNO" ); // retrieve IVWEB_VIN from HTTP Session

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	
	
	
	// check for session timed out
	if( IVWEB_SEQNO == null ) {
		String errorMsg = "<H3>No Trusted Mechanic has been selected yet ...</H3>";
	   	//String redirectMsg = "<br>Redirecting to Select Vehicle ...";
	    	
	   	out.println( errorMsg );
	} else {
			
		
%>

<form name="searchobd2" action="/ivweb/obd2PIDSetParamsToSearchTM.jsp" onsubmit="return validateOBD2Code()" method="post">

Code: <input type="text" name="obd2code"   maxlength="5" size="5" value=""/>
Year:  <select name="car-years"       id="car-years"></select> &nbsp;
Make:  <select name="car-makes"       id="car-makes"></select> &nbsp;
Model: <select name="car-models"      id="car-models"></select> &nbsp;
Trim:  <select name="car-model-trims" id="car-model-trims"></select> &nbsp;

<INPUT type="submit" value="Search">

</form>

<BR> <BR>

<iframe src="/ivweb/showOBD2SearchResultsTM.jsp" align="middle" width="100%" height="400px"></iframe>

<%
	}
}
%>

</font>

</body>
</html>