<%--*******************************************************************
 *	RealityUWeb: index.jsp
 *  03/17/2014
 *******************************************************************--%>
<%@page import="java.util.List"%>
<% 
//RESET ALL "ADMIN" SESSION OBJECTS TO NULL TO CLEAR OUT VALUES
obj.Group grp = null;
List<obj.Survey> lstSurvs = null;
obj.Occupation ocp = null;
obj.Survey surv = null;
String msg = null;
HttpSession ses1 = request.getSession();
//For newgroup.jsp
ses1.setAttribute("newGrp", grp);
ses1.setAttribute("newGroupMsg", msg);
//For opengroup.jsp
ses1.setAttribute("openGrp", grp);
ses1.setAttribute("lstSurveys", lstSurvs);
ses1.setAttribute("editGroupMsg", msg);
//For occupations.jsp
ses1.setAttribute("occupsMsg", msg);
//For editoccups.jsp
ses1.setAttribute("editOccp", ocp);
ses1.setAttribute("editOccupsMsg", msg);
//For surveview.jsp
ses1.setAttribute("surveyviewGrp", grp);
ses1.setAttribute("viewSurvey", surv);
ses1.setAttribute("surveyMssg", msg);
%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

<title>Communities In Schools - Reality U</title>
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

<!--FOR shadow 100% 'BACKGROUND-SIZE' IN OLDER IE BROWSERS <IE8-->
<!--[if lt IE 9]>
	<style type="text/css">
		/*SET BOX WIDTH = TO EXACT BACKGRD SHADOW IMAGE WIDTH - NO SCALING*/
		#box1 {width: 200px !important; padding: 0 !important;}
		#box2 {width: 200px !important; padding: 0 !important;}
		#box3 {width: 200px !important; padding: 0 !important;}	
		
		/*NEED TO TAKE AWAY PADDING ON box ELEMENT (w/ image), AND ADD TO form ELEMENT*/
		.addPad {padding: 0 5px !important;}	
		
		/*OR COULD TAKE BACKGRD IMAGE AWAY ENTIRELY - THEN ALLOWS SCALING*/
		/*
		#box1 {background-image: none;}
		#box2 {background-image: none;}
		#box3 {background-image: none;}
		*/
	</style>	
<![endif]-->


<!-- FORM VALIDATION -->
<script type="text/javascript">
    function validateStudent(myform) {
        var num = 0;
        var message = "";
        if(myform.accesscode.value == "") {
            message += "- Student Access Code must be completed \n";
            num = 1;
        } 
        if(myform.lName.value == "") {
            message += "- Student's Last Name must be completed \n";
            num = 1;
        }
        if(myform.dob.value == "") {
            message += "- Student's Birthdate must be completed \n";
            num = 1;
        }		
        if (num == 1) { 
            alert ("Please complete or correct the following required fields: \n\n"+message);
            return false;
        } else {
            return true;
        } //end if
    } //end func

    function validateAdmin(myform) {
        var num = 0;
        var message = "";
        if(myform.userid.value == "") {
            message += "- Userid must be completed \n";
            num = 1;
        } 
        if(myform.password.value == "") {
            message += "- Password must be completed \n";
            num = 1;
        }
        if (num == 1) { 
            alert ("Please complete or correct the following required fields: \n\n"+message);
            return false;
        } else {
            return true;
        } //end if
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
		<!--ADD NAVIGATION -->
</div><!--END NAVIGATION-->


</div><!--END HEADER-->




<!--MAIN CONTENT CONTAINER -->
<div id="main">

<br><br>

<fieldset>
<h3>Reality U - Preparing Students For The Real World</h3>

<p>
Communities In Schools of Marietta/Cobb County hosts financial literacy events known as Reality U.  The events help students understand the realities involved in preparing for adulthood and an employable future.  The goal is to learn about the correlation between fiscal well-being, academic achievement and financial literacy, while role playing real life situations.
</p>
<p>
Participating students are provided an adult scenario complete with marital status, number of children, occupation and net monthly income.  They then visit a variety of booths operated by community volunteers to purchase housing, transportation, child care, food, utilities and insurance just to name a few.
</p>
</fieldset>

<br><br>

<fieldset>
<h3>Students</h3>

<p>
Students must first fill out a survey, answering questions about what their expected life will be like when they are 26 years old. To obtain access to the survey, students must get a Student Access Code from their teacher, and enter it in the space provided below. Entering the access code will take students to the survey, which must be completed prior to the Reality U event date.
</p>
</fieldset>

<br><br>

<div id="loginArea">

	<table>
	  <tr>
		<td>
			<div id="box1">
				<form class="addPad" method="post" action="http://localhost:8080/RealityUWeb/StudentAccessServlet" onSubmit="return validateStudent(this);">
				<h3 class="blackHead">Student Survey</h3>
					<div class="studentInputs">
						<label>Student Access Code:</label>
						<input type="text" name="accesscode">
					</div>
					<div class="studentInputs">
						<label>Last Name:</label>
						<input type="text" name="lName">
					</div>
					<div class="studentInputs">
						<label>Birthdate:</label>
						<input type="text" name="dob">
					</div>
					<br>
					<div class="bottomAlign">
						<input class="submit" type="submit" value="Go To Survey     >>  ">
					</div>
				</form>
			</div>
		</td>
		<td>
			<div id="box2">
				<form class="addPad" method="post" action="http://localhost:8080/RealityUWeb/AdminLoginServlet" onSubmit="return validateAdmin(this);">
				<h3 class="blackHead">Admin Login</h3>
					<div class="adminInputs">
						<label>Userid:</label>
						<input type="text" name="userid">
					</div>
					<div class="adminInputs">
						<label>Password:</label>
						<input type="password" name="password">
					</div>
					<br>	
					<div class="bottomAlign2">					
						<input class="submit" type="submit" value="Login     >>  ">
					</div>
				</form>
			</div>
		</td>
		<td>
			<div id="box3">
				<form class="addPad" method="post" action="http://localhost:8080/RealityUWeb/AdminLoginServlet" onSubmit="return validateAdmin(this);">
				<h3 class="blackHead">Admin Registration</h3>
				<p id="regisBoxText">
				If you do not already have an Admin userid, you must login with the 
				Master Userid and Password in order to Register.
				</p>
				<br><br>
					<div class="adminInputs">
						<label>Userid:</label>
						<input type="text" name="userid">
					</div>
					<div class="adminInputs">
						<label>Password:</label>
						<input type="password" name="password">
					</div>
					<input type="hidden" name="checkMasterLogin" value="checkMasterLogin">
					<br>	
					<div class="bottomAlign3">				
						<input class="submit" type="submit" value="Register Now     >>  ">
					</div>
				</form>					
			</div>
		</td>
	  </tr>
	</table>

</div><!--END loginArea-->



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