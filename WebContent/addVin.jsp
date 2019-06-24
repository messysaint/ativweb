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

<script type="text/javascript" src="/ivweb/jscript/validateAddVinForm.js"></script>

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

String sessiontimeout = "/ivweb/z_securityquery.jsp";

String loginVehicle = "&nbsp;&nbsp;&nbsp;&nbsp;[&nbsp; <A href=\"/ivweb/selectVehicle.jsp\">Login as Vehicle Owner</A> &nbsp;]";
String viewTestVehicle = "&nbsp;&nbsp;[&nbsp; <A href=\"/ivweb/viewTestVehicle.jsp\">View Test Vehicle</A> &nbsp;] ";

checkAuth check = new checkAuth(); 

String IsHuman = (String) session.getAttribute( "IVWEB_ISHUMAN" );

if( !check.isLoggedIn( IsHuman ) ) {	// if not logged in, ask user to log in
	response.sendRedirect( sessiontimeout );
} else { 
	
%>


<table border="0">
 <tr>    
    <th><h3>Add New Vehicle:</h3></th>    
    <th><%=loginVehicle%></th> 
  </tr>
</table>

<form name="addnewvehicle" action="/ivweb/saveNewVinToDB.jsp" onsubmit="return validateAddNewVehicleForm()" method="post">

Year:  <select name="car-years"       id="car-years"></select> &nbsp;
Make:  <select name="car-makes"       id="car-makes"></select> &nbsp;
Model: <select name="car-models"      id="car-models"></select> &nbsp;
Trim:  <select name="car-model-trims" id="car-model-trims"></select> &nbsp;

<input id="cq-show-data" type="button" value="Details" /> <br><br>
<div id="car-model-data"></div>

<br>

<table border="0">

  <tr>
    <td>Select Country: &nbsp;</td>
    <td>
<select name="country" size="1">
<option value="Afghanistan">Afghanistan</option>
<option value="Aland Islands">Aland Islands</option>
<option value="Albania">Albania</option>
<option value="Algeria">Algeria</option>
<option value="American Samoa">American Samoa</option>
<option value="Andorra">Andorra</option>
<option value="Angola">Angola</option>
<option value="Anguilla">Anguilla</option>
<option value="Antarctica">Antarctica</option>
<option value="Antigua and Barbuda">Antigua and Barbuda</option>
<option value="Argentina">Argentina</option>
<option value="Armenia">Armenia</option>
<option value="Aruba">Aruba</option>
<option value="Australia">Australia</option>
<option value="Austria">Austria</option>
<option value="Azerbaijan">Azerbaijan</option>
<option value="Bahamas">Bahamas</option>
<option value="Bahrain">Bahrain</option>
<option value="Bangladesh">Bangladesh</option>
<option value="Barbados">Barbados</option>
<option value="Belarus">Belarus</option>
<option value="Belgium">Belgium</option>
<option value="Belize">Belize</option>
<option value="Benin">Benin</option>
<option value="Bermuda">Bermuda</option>
<option value="Bhutan">Bhutan</option>
<option value="Bolivia">Bolivia</option>
<option value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>
<option value="Botswana">Botswana</option>
<option value="Bouvet Island">Bouvet Island</option>
<option value="Brazil">Brazil</option>
<option value="British Indian Ocean Territory">British Indian Ocean Territory</option>
<option value="Brunei Darussalam">Brunei Darussalam</option>
<option value="Bulgaria">Bulgaria</option>
<option value="Burkina Faso">Burkina Faso</option>
<option value="Burundi">Burundi</option>
<option value="Cambodia">Cambodia</option>
<option value="Cameroon">Cameroon</option>
<option value="Canada">Canada</option>
<option value="Cape Verde">Cape Verde</option>
<option value="Cayman Islands">Cayman Islands</option>
<option value="Central African Republic">Central African Republic</option>
<option value="Chad">Chad</option>
<option value="Chile">Chile</option>
<option value="China">China</option>
<option value="Christmas Island">Christmas Island</option>
<option value="Cocos (Keeling) Islands">Cocos (Keeling) Islands</option>
<option value="Colombia">Colombia</option>
<option value="Comoros">Comoros</option>
<option value="Congo">Congo</option>
<option value="Congo, Democratic Republic">Congo, Democratic Republic</option>
<option value="Cook Islands">Cook Islands</option>
<option value="Costa Rica">Costa Rica</option>
<option value="Ivory Coast">Ivory Coast</option>
<option value="Croatia">Croatia</option>
<option value="Cuba">Cuba</option>
<option value="Cyprus">Cyprus</option>
<option value="Czech Republic">Czech Republic</option>
<option value="Denmark">Denmark</option>
<option value="Djibouti">Djibouti</option>
<option value="Dominica">Dominica</option>
<option value="Dominican Republic">Dominican Republic</option>
<option value="East Timor">East Timor</option>
<option value="Ecuador">Ecuador</option>
<option value="Egypt">Egypt</option>
<option value="El Salvador">El Salvador</option>
<option value="Equatorial Guinea">Equatorial Guinea</option>
<option value="Eritrea">Eritrea</option>
<option value="Estonia">Estonia</option>
<option value="Ethiopia">Ethiopia</option>
<option value="Falkland Islands">Falkland Islands</option>
<option value="Faroe Islands">Faroe Islands</option>
<option value="Fiji">Fiji</option>
<option value="Finland">Finland</option>
<option value="France">France</option>
<option value="French Guiana">French Guiana</option>
<option value="French Polynesia">French Polynesia</option>
<option value="French Southern Territories">French Southern Territories</option>
<option value="Gabon">Gabon</option>
<option value="Gambia">Gambia</option>
<option value="Georgia">Georgia</option>
<option value="Germany">Germany</option>
<option value="Ghana">Ghana</option>
<option value="Gibraltar">Gibraltar</option>
<option value="Greece">Greece</option>
<option value="Greenland">Greenland</option>
<option value="Grenada">Grenada</option>
<option value="Guadeloupe">Guadeloupe</option>
<option value="Guam">Guam</option>
<option value="Guatemala">Guatemala</option>
<option value="Guinea">Guinea</option>
<option value="Guinea-Bissau">Guinea-Bissau</option>
<option value="Guyana">Guyana</option>
<option value="Haiti">Haiti</option>
<option value="Heard and McDonald Islands">Heard and McDonald Islands</option>
<option value="Honduras">Honduras</option>
<option value="Hong Kong">Hong Kong</option>
<option value="Hungary">Hungary</option>
<option value="Iceland">Iceland</option>
<option value="India">India</option>
<option value="Indonesia">Indonesia</option>
<option value="Iran">Iran</option>
<option value="Iraq">Iraq</option>
<option value="Ireland">Ireland</option>
<option value="Israel">Israel</option>
<option value="Italy">Italy</option>
<option value="Jamaica">Jamaica</option>
<option value="Japan">Japan</option>
<option value="Jordan">Jordan</option>
<option value="Kazakhstan">Kazakhstan</option>
<option value="Kenya">Kenya</option>
<option value="Kiribati">Kiribati</option>
<option value="Korea, North ">Korea, North</option>
<option value="Korea, South ">Korea, South</option>
<option value="Kuwait">Kuwait</option>
<option value="Kyrgyzstan">Kyrgyzstan</option>
<option value="Lao Peoples Democratic Republic">Lao Peoples Democratic Republic</option>
<option value="Latvia">Latvia</option>
<option value="Lebanon">Lebanon</option>
<option value="Lesotho">Lesotho</option>
<option value="Liberia">Liberia</option>
<option value="Libyan Arab Jamahiriya">Libyan Arab Jamahiriya</option>
<option value="Liechtenstein">Liechtenstein</option>
<option value="Lithuania">Lithuania</option>
<option value="Luxembourg">Luxembourg</option>
<option value="Macao">Macao</option>
<option value="Macedonia, Former Yugoslav Republic Of">Macedonia, Former Yugoslav Republic Of</option>
<option value="Madagascar">Madagascar</option>
<option value="Malawi">Malawi</option>
<option value="Malaysia">Malaysia</option>
<option value="Maldives">Maldives</option>
<option value="Mali">Mali</option>
<option value="Malta">Malta</option>
<option value="Marshall Islands">Marshall Islands</option>
<option value="Martinique">Martinique</option>
<option value="Mauritania">Mauritania</option>
<option value="Mauritius">Mauritius</option>
<option value="Mayotte">Mayotte</option>
<option value="Mexico">Mexico</option>
<option value="Micronesia">Micronesia</option>
<option value="Moldova">Moldova</option>
<option value="Monaco">Monaco</option>
<option value="Mongolia">Mongolia</option>
<option value="Montenegro">Montenegro</option>
<option value="Montserrat">Montserrat</option>
<option value="Morocco">Morocco</option>
<option value="Mozambique">Mozambique</option>
<option value="Myanmar">Myanmar</option>
<option value="Namibia">Namibia</option>
<option value="Nauru">Nauru</option>
<option value="Nepal">Nepal</option>
<option value="Netherlands">Netherlands</option>
<option value="Netherlands Antilles">Netherlands Antilles</option>
<option value="New Caledonia">New Caledonia</option>
<option value="New Zealand">New Zealand</option>
<option value="Nicaragua">Nicaragua</option>
<option value="Niger">Niger</option>
<option value="Nigeria">Nigeria</option>
<option value="Niue">Niue</option>
<option value="Norfolk Island">Norfolk Island</option>
<option value="Northern Mariana Islands">Northern Mariana Islands</option>
<option value="Norway">Norway</option>
<option value="Oman">Oman</option>
<option value="Pakistan">Pakistan</option>
<option value="Palau">Palau</option>
<option value="Palestinian Territories">Palestinian Territories</option>
<option value="Panama">Panama</option>
<option value="Papua New Guinea">Papua New Guinea</option>
<option value="Paraguay">Paraguay</option>
<option value="Peru">Peru</option>
<option value="Philippines">Philippines</option>
<option value="Pitcairn">Pitcairn</option>
<option value="Poland">Poland</option>
<option value="Portugal">Portugal</option>
<option value="Puerto Rico">Puerto Rico</option>
<option value="Qatar">Qatar</option>
<option value="R&eacute;union">R&eacute;union</option>
<option value="Romania">Romania</option>
<option value="Russian Federation">Russian Federation</option>
<option value="Rwanda">Rwanda</option>
<option value="Saint Helena">Saint Helena</option>
<option value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>
<option value="Saint Lucia">Saint Lucia</option>
<option value="Saint Pierre and Miquelon">Saint Pierre and Miquelon</option>
<option value="Saint Vincent and the Grenadines">Saint Vincent and the Grenadines</option>
<option value="Samoa">Samoa</option>
<option value="San Marino">San Marino</option>
<option value="Sao Tome and Principe">Sao Tome and Principe</option>
<option value="Saudi Arabia">Saudi Arabia</option>
<option value="Senegal">Senegal</option>
<option value="Serbia">Serbia</option>
<option value="Seychelles">Seychelles</option>
<option value="Sierra Leone">Sierra Leone</option>
<option value="Singapore">Singapore</option>
<option value="Slovakia">Slovakia</option>
<option value="Slovenia">Slovenia</option>
<option value="Solomon Islands">Solomon Islands</option>
<option value="Somalia">Somalia</option>
<option value="South Africa">South Africa</option>
<option value="South Georgia and the South Sandwich Islands">South Georgia and the South Sandwich Islands</option>
<option value="Spain">Spain</option>
<option value="Sri Lanka">Sri Lanka</option>
<option value="Sudan">Sudan</option>
<option value="South Sudan">South Sudan</option>
<option value="Suriname">Suriname</option>
<option value="Svalbard and Jan Mayen Islands">Svalbard and Jan Mayen Islands</option>
<option value="Swaziland">Swaziland</option>
<option value="Sweden">Sweden</option>
<option value="Switzerland">Switzerland</option>
<option value="Syria">Syria</option>
<option value="Taiwan">Taiwan</option>
<option value="Tajikistan">Tajikistan</option>
<option value="Tanzania">Tanzania</option>
<option value="Thailand">Thailand</option>
<option value="Togo">Togo</option>
<option value="Tokelau">Tokelau</option>
<option value="Tonga">Tonga</option>
<option value="Trinidad and Tobago">Trinidad and Tobago</option>
<option value="Tunisia">Tunisia</option>
<option value="Turkey">Turkey</option>
<option value="Turkmenistan">Turkmenistan</option>
<option value="Turks and Caicos Islands">Turks and Caicos Islands</option>
<option value="Tuvalu">Tuvalu</option>
<option value="Uganda">Uganda</option>
<option value="Ukraine">Ukraine</option>
<option value="United Arab Emirates">United Arab Emirates</option>
<option value="United Kingdom">United Kingdom</option>
<option value="United States of America" selected="selected">United States of America</option>
<option value="Uruguay">Uruguay</option>
<option value="Uzbekistan">Uzbekistan</option>
<option value="Vanuatu">Vanuatu</option>
<option value="Vatican City">Vatican City</option>
<option value="Venezuela">Venezuela</option>
<option value="Vietnam">Vietnam</option>
<option value="Virgin Islands (British)">Virgin Islands (British)</option>
<option value="Virgin Islands (US)">Virgin Islands (US)</option>
<option value="Wallis and Futuna Islands">Wallis and Futuna Islands</option>
<option value="Western Sahara">Western Sahara</option>
<option value="Yemen">Yemen</option>
<option value="Zaire">Zaire</option>
<option value="Zambia">Zambia</option>
<option value="Zimbabwe">Zimbabwe</option>
</select>
    </td>
  </tr>

  <tr>
    <td>ZIP Code: &nbsp;</td>
    <td><input type="text" name="zipcode"   maxlength="10" size="10" value=""/> </td>
  </tr>

  <tr>
    <td>Enter VIN: &nbsp;</td>
    <td><input type="text" name="vin"   maxlength="17" size="17" value=""/> </td>
  </tr>
  <tr>
    <td>Re-Enter VIN: &nbsp;</td>
    <td><input type="text" name="revin" maxlength="17" size="17" value=""/></td>
  </tr>
  
  <tr>
    <td>Email: &nbsp;</td>
    <td><input type="text" name="email"   maxlength="30" size="30" value=""/> </td>
  </tr>
  
  <tr>
    <td>Re-Enter Email: &nbsp;</td>
    <td><input type="text" name="reemail" maxlength="30" size="30" value=""/> </td>
  </tr>

  <tr>
    <td>Reminder Question: &nbsp;</td>
    <td><input type="text" name="reminderquestion" maxlength="50" size="50" value=""/> </td>
  </tr>
  
  <tr>
    <td>Reminder Answer: &nbsp;</td>
    <td><input type="text" name="reminderanswer"   maxlength="50" size="50" value=""/> </td>
  </tr>
  
</table> 
    
<br>
<br>

<INPUT type="submit" value="Add this Vehicle">
</form>

<%
}
%>

</font>

</body>
</html>