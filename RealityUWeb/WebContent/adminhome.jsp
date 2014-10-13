<%--*******************************************************************
 *	RealityUWeb: adminhome.jsp
 *  03/17/2014
 *******************************************************************--%>
<%@page import="java.util.List"%>
<% 
//RESET ALL SESSION OBJECTS TO NULL TO CLEAR OUT VALUES
obj.Group grpp = null;
List<obj.Survey> lstSurvs = null;
obj.Occupation ocp = null;
obj.Survey survey = null;
String mssg = null;
HttpSession ses1 = request.getSession();
//For newgroup.jsp
ses1.setAttribute("newGrp", grpp);
ses1.setAttribute("newGroupMsg", mssg);
//For opengroup.jsp
ses1.setAttribute("openGrp", grpp);
ses1.setAttribute("lstSurveys", lstSurvs);
ses1.setAttribute("editGroupMsg", mssg);
ses1.setAttribute("isProcessed", mssg);
//For occupations.jsp
ses1.setAttribute("occupsMsg", mssg);
//For editoccups.jsp
ses1.setAttribute("editOccp", ocp);
ses1.setAttribute("editOccupsMsg", mssg);
//For surveyview.jsp
ses1.setAttribute("surveyviewGrp", grpp);
ses1.setAttribute("viewSurvey", survey);
ses1.setAttribute("surveyMssg", mssg);
//For surveprocessed.jsp	
ses1.setAttribute("surveyprocessGrp", grpp);
ses1.setAttribute("processSurvey", survey);
ses1.setAttribute("surveyProcMsg", mssg);
%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

<title>Communities In Schools - Reality U Admin</title>
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
		#mainArea #box1 {width: 200px !important; padding: 0 !important;}
		#mainArea #box2 {width: 200px !important; padding: 0 !important;}
		#mainArea #box3 {width: 200px !important; padding: 0 !important;}
		#mainArea #box4 {width: 200px !important; padding: 0 !important;}
		
		/*NEED TO TAKE AWAY PADDING ON box ELEMENT (w/ image), AND ADD TO <h3> ELEMENT*/
		.addPad { padding: 5px !important;}		
		
		/*OR COULD TAKE BACKGRD IMAGE AWAY ENTIRELY - THEN ALLOWS SCALING*/
		/*
		#mainArea #box1 {background-image: none;}
		#mainArea #box2 {background-image: none;}
		#mainArea #box3 {background-image: none;}
		#mainArea #box4 {background-image: none;}
		*/
	</style>
<![endif]-->


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
	<li><a href="adminhome.jsp">Admin Home</a></li>
	<li><a href="newgroup.jsp">New Group</a></li>
    <li><a href="opengroup.jsp">Open Group</a></li>
	<li><a href="occupations.jsp">Edit Occupations</a></li>
    <li><a href="helpadmin.html">Help</a></li>
  </ul>
</div><!--END NAVIGATION-->


</div><!--END HEADER-->




<!--MAIN CONTENT CONTAINER -->
<div id="main">

<br><br>

<fieldset>
<h3>Administration</h3>
</fieldset>



<br><br>

<div id="mainArea">

	<table>
	  <tr>
		<td>
			<div id="box1">
				<h3 class="blackHeadCenter addPad">New Group</h3>
				<div class="icon">
					<img src="images/iconaddgroup.png" width="128" height="128" alt="Open New Group">
				</div>
					<br>
				<div class="bottomAlign">
					<a id="adminButton" href="newgroup.jsp">New Group&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>>&nbsp;&nbsp;</a> 
				</div>
			</div>
		</td>
		<td>
			<div id="box2">
				<h3 class="blackHeadCenter addPad">Open Group</h3>
				<div class="icon">
					<img src="images/iconopengroup.png" width="128" height="128" alt="Open Group">
				</div>
					<br>
				<div class="bottomAlign2">
					<a id="adminButton" href="opengroup.jsp">Open Group&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>>&nbsp;&nbsp;</a> 
				</div>
			</div>
		</td>
		<td>
			<div id="box3">
				<h3 class="blackHeadCenter addPad">Edit Occupations</h3>
				<div class="icon">
					<img src="images/iconeditoccup.png" width="128" height="128" alt="Edit Occupations">
				</div>
					<br>
				<div class="bottomAlign3">
					<a id="adminButton" href="occupations.jsp">Edit Occupations&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>>&nbsp;&nbsp;</a> 
				</div>
			</div>
		</td>
		<td>
			<div id="box4">
				<h3 class="blackHeadCenter addPad">Help</h3>
				<div class="icon">
					<img src="images/iconhelp.png" width="128" height="128" alt="Help">
				</div>
					<br>
				<div class="bottomAlign4">
					<a id="adminButton" href="helpadmin.html">Help&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>>&nbsp;&nbsp;</a> 
				</div>
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




























