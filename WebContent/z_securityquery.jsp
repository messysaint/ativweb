<%--
 % Example for using the Webservice http://captchas.net 
 % Replace the required parameters 'demo' and 'secret' with the
 % values you receive upon http://captchas.net/registration/ .
 % 
 % Optional Parameters and Defaults:
 % 
 % alphabet: abcdefghkmnopqrstuvwxyz (Used characters in captcha)
 % We recommend alphabet without mistakable ijl
 % 
 % letters: 6 (Number of characters in captcha)
 % 
 % width: 240 (image width)
 % height: 80 (image height)
 % 
 % Don't forget the same settings in check.jsp
 
 % 
 
 --%>

<%@ page language="java" import="captchas.CaptchasDotNet" %>

<%@ page errorPage="showError.jsp" %>

<html>

<font face="Georgia, Arial, Garamond" size = "2">

<%
// Construct the captchas object (Default Values)
CaptchasDotNet captchas = new captchas.CaptchasDotNet(
  request.getSession(true),     // Ensure session
  "bmutia",                       // client
  "XhOcgdSNMslCM7LsOI782XE0i0s0z1c6ze4HX61J"                      // secret
  );
// Construct the captchas object (Extended example)
// CaptchasDotNet captchas = new captchas.CaptchasDotNet(
//  request.getSession(true),     // Ensure session
//  "demo",                       // client
//  "secret",                     // secret
//  "01",                         // alphabet
//  16,                           // letters
//  500,                          // width
//  80                            // height
//  );
%>
  <%-- 
   % encodeUrl produces jsessionid=xyz in case of disabled cookies
   % Please test your implementation also with disabled cookies
   --%>
   
  
  
  <div align="center" >
  
  <form method="get" action="<%=response.encodeUrl("z_securitycheck.jsp")%>">
  
    <table>
            
      <tr>
        <td>
          
        </td>
      </tr>
      
      <tr>
        <td>
          Security check ...
        </td>
      </tr>
      
      <tr>
        <td>
          <input name="password" size="16" />
        </td>
      </tr>
      
      <tr>
        <td>
          <%= captchas.image() %><br>
          <%--
          <a href="<%= captchas.audioUrl() %>">Phonetic spelling (mp3)</a>
           --%>
        </td>
      </tr>
      
      <tr>
        <td>
          <input type="submit" value="Submit" />
        </td>  
      </tr>
      
    </table>
    
  </form>
  
  </div> 
  
  </font>
  
</html>