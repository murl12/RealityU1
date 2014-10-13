<%--*******************************************************************
 *	RealityUWeb: regis.jsp
 *  03/17/2014
 *******************************************************************--%>
<% 
obj.Administrator a2 =(obj.Administrator)session.getAttribute("adm2");
%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

<title>Communities In Schools - Reality U Admin Registration</title>
<meta charset="utf-8">
<!--Edge = render site in highest standards mode possible 8, 9..., chrome = use Google engine if installed-->

<meta http-equiv="pragma" content="no-cache">

<link rel="stylesheet" href="css/reset.css" media="screen">
<link rel="stylesheet" href="css/mainstyles.css" media="screen">

<!--FOR STICKY FOOTER IN OLDER IE BROWSERS (except IE 7 OK)-->
<!--[if (lt IE 9) & (!(IE 7))]>
	<style type="text/css">
		#wrapper {display:table; height:100%;}
	</style>
<![endif]-->

<!-- FORM VALIDATION -->
<script type="text/javascript">
    	
   //Value of 'btn' set via onclick on submit/clear buttons at end of form
   var btn = "";
   	
   function validate(myform) {	
       	if (btn == "submit") {
       		//Validate Form only on 'submit' button (not for 'clear' button)   	
	        var num = 0;
	        var message = "";
	        if(myform.firstname.value == "") {
	            message += "- First Name must be completed \n";
	            num = 1;
	        } 
	        if(myform.lastname.value == "") {
	            message += "- Last Name must be completed \n";
	            num = 1;
	        }
	        if(myform.userid.value == "") {
	            message += "- Userid must be completed \n";
	            num = 1;
	        }
	        if(myform.password.value == "") {
	            message += "- Password must be completed \n";
	            num = 1;
	        }	
	        if(myform.password2.value == "") {
	            message += "- Password Confirmation must be completed \n";
	            num = 1;
	        }
	        if(myform.password2.value != myform.password.value && myform.password2.value != "") {
	            message += "- Passwords don't match. Re-enter password. \n";
	            num = 1;
	        }
	        if (num == 1) { 
	            alert ("Please complete or correct the following required fields: \n\n"+message);
	            return false;
	        } else {
	            return true;
	        } //end if
        } //end button if
    } //end func
</script>


</head>

<body>
<div id="wrapper">
 
<!--HEADER-->
<div id="header">

<img id="logoImg" src="images/cislogo.png" width="200" height="150" alt="Communities In Schools Logo">


<!--Header Text-->
<img id="headerText" src="images/realityuhead.png" width="600" height="80" alt="Reality University Program">
<!--REALITY U LOGO-->
<img id="logoImg2" src="images/realityulogo.png" width="100" height="95" alt="Reality U Logo">

<!--NAVIGATION-->
<div id="nav">
  <ul>
  	<li><a href="index.jsp">Home</a></li>
	
<!--	
	<li><a href="adminhome.html">Admin Home</a></li>
	<li><a href="newgroup.html">New Group</a></li>
    <li><a href="opengroup.html">Open Group</a></li>
	<li><a href="editoccups.html">Edit Occupations</a></li>
-->
	
    <li><a href="helpadmin.html">Help</a></li>
  </ul>
</div><!--END NAVIGATION-->


</div><!--END HEADER-->




<!--MAIN CONTENT CONTAINER -->
<div id="main">

<br><br>

<fieldset>
<h3>Administration - Registration</h3>
</fieldset>



<br><br>

<div id="mainArea">

<!--START FORM-->
<form id="newGroupForm" method="post" action="http://localhost:8080/RealityUWeb/AdminRegisServlet" onSubmit="return validate(this);">

<fieldset>
<br><br>

<% 
//If form never been filled in yet, all values are blank
if (session.getAttribute("adm2") == null) {
%>
	<div>
		<label id="firstname">First Name:</label>
		<input type="text" name="firstname" value="">
	</div>
	<div>
		<label id="lastname">Last Name:</label>
		<input type="text" name="lastname" value="">
	</div>
	<div>
		<label id="userid">Userid:</label>
		<input type="text" name="userid" value="">
	</div>
	<div>
		<label id="password">Password:</label>
		<input type="text" name="password" value="">
	</div>
	<div>
		<label id="password2">Confirm Password:</label>
		<input type="text" name="password2" value="">
	</div>
	
<%
//If form filled in and checked on server but not valid: have dupe
//username and/or password, fill in with previous values with error message
} else { 
%> 	
	<div>
		<label id="firstname">First Name:</label>
		<input type="text" name="firstname" value="<%=a2.getFname()%>">
	</div>
	<div>
		<label id="lastname">Last Name:</label>
		<input type="text" name="lastname" value="<%=a2.getLname()%>">
	</div>
	<div>
		<% 
		//If dupe userid, show message
		//Key: id 1=dupe userid, 2=dupe pw, 3=dupe both
		if (a2.getId() == 1 || a2.getId() == 3) { 
		%>
		<span class="inputErrorMsg">THIS USERID ALREADY USED. PLEASE RE-TRY</span><br><br>
		<% } //end if %>
		<label id="userid">Userid:</label>
		<input type="text" name="userid" value="<%=a2.getUsername()%>">
	</div>
	<div>
		<% 
		//If dupe password, show message
		if (a2.getId() == 2 || a2.getId() == 3) { 
		%>
		<span class="inputErrorMsg">THIS PASSWORD ALREADY USED. PLEASE RE-TRY</span><br><br>
		<% } //end if %>
		<label id="password">Password:</label>
		<input type="text" name="password" value="<%=a2.getPassword()%>">
	</div>
	<div>
		<label id="password2">Confirm Password:</label>
		<input type="text" name="password2" value="<%=a2.getPassword()%>">
	</div>
		
<% } //end if %>


</fieldset>

<br>

<!--SUBMIT FORM BUTTONS-->
		<div id="formButtonsContainer">
		  <div id="formButtons">
			<input type="submit" value="Register" id="submit" name="submit" onclick="btn='submit';">
			<input type="submit" value="Clear" id="clear" name="clear" onclick="btn='clear';">
		  </div>
		</div>

<br><br>

<!--END FORM-->
</form>

</div><!--END mainArea-->



</div><!--END Main Area-->


<!--FOR STICKY FOOTER-->
<div id="push"></div>


</div><!--END Content Wrapper-->


<!--FOOTER OUTSIDE WRAPPER-->
<div id="footer" class="legal">
Copyright &copy; 2009-2014 CIS of Marietta/Cobb County
</div><!--END FOOTER-->


</body>
</html>




























