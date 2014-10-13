<%--*******************************************************************
 *	RealityUWeb: opengroup.jsp
 *  04/14/2014
 *******************************************************************--%>
<%@page import="dao.GroupsDAO"%>
<%@page import="obj.Group"%>
<%@page import="obj.Survey"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<% 
//RESET ALL SESSION OBJECTS TO NULL TO CLEAR OUT VALUES
Group grpp = null;
obj.Occupation ocp = null;
Survey survey = null;
String mssg = null;
HttpSession ses1 = request.getSession();
//For newgroup.jsp
ses1.setAttribute("newGrp", grpp);
ses1.setAttribute("newGroupMsg", mssg);
//For opengroup.jsp
	//DON'T CLEAR FOR THIS PAGE
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

obj.Group openGrp =(obj.Group)session.getAttribute("openGrp");
//If form never been filled in yet, Group obj will be null so
//need to set all Group values to blank/empty by using default Group constructor
if (session.getAttribute("openGrp") == null) {
	openGrp = new Group(); //all values 0 or ""
}

//Declare variables for Group List of all Groups to use in dropdown
List<Group> lstGroups = new ArrayList<Group>();
GroupsDAO gd = new GroupsDAO();
lstGroups = gd.findAllGroups();

//Declare variables for list of Surveys
List<Survey> lstSurveys = new ArrayList<Survey>();
//Get List of Surveys from Session if it exists
if (session.getAttribute("lstSurveys") != null) {
	lstSurveys = (List<Survey>)session.getAttribute("lstSurveys");
	System.out.println("Retrieved List of Surveys Obj in 'opengroup.jsp'.");
} //end if

//Get String from Session to determine if Group has been processed
String isProcessed = null;
if (session.getAttribute("isProcessed") != null) {
	isProcessed = (String)session.getAttribute("isProcessed");
}

%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

<title>Communities In Schools - Reality U Admin Open Group</title>
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
	
    function validate(myform) {
       		//Validate Form only on 'submit' button (not for 'clear' button)
	        var num = 0;
	        var message = "";
	        if(myform.name.value == "") {
	            message += "- Group Name must be completed \n";
	            num = 1;
	        } 
	        if(myform.highschool.value == "") {
	            message += "- High School must be completed \n";
	            num = 1;
	        }
	        if(myform.teacher.value == "") {
	            message += "- Teacher must be completed \n";
	            num = 1;
	        }
	        if(myform.classPeriod.value == "") {
	            message += "- Period must be completed \n";
	            num = 1;
	        }	
	        if(myform.surveyStartDate.value == "") {
	            message += "- Survey Start Date must be completed \n";
	            num = 1;
	        }
	        if(myform.surveyEndDate.value == "") {
	            message += "- Survey End Date must be completed \n";
	            num = 1;
	        }
	        if(myform.eventDate.value == "") {
	            message += "- Event Date must be completed \n";
	            num = 1;
	        }
	
	        if (num == 1) { 
	            alert ("Please complete or correct the following required fields: \n\n"+message);
	            return false;
	        } else {
	            return true;
	        } //end if

    } //end func
    
  //======================== CHECK SURVEY BUTTON FUNCTION ===========================
	//Value of 'btn' set via onclick on submit buttons at end of form
	var btn = "";
    function checkFunction(myform) {
    	if (btn == "print") {
       		//Don't submit form, for printing only
       		return false;
    	} else if (btn == "delete") {
    		//Confirm if want to delete
    		var result = confirm("Are you sure you want to permanently delete this survey?");
    		//Remove so doesn't open in new window
    		myform.removeAttribute('target');
    		return result;
    	} else { 
    		//Submit Button, or Processed Button
    		//Open in new window
    		myform.setAttribute('target', '_blank');
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
<h3>Administration - Open Group</h3>
</fieldset>



<br><br>

<div id="mainArea">

<!--START FORM-->
<form id="newGroupForm" method="post" action="http://localhost:8080/RealityUWeb/NewGroupServlet">
<fieldset>
<br><br>
		<div class="sameLine">
			<label for="groupid">Select Group:</label> 
			<select name="groupid" >
				<%   
				String select;
                //Loop thru list of all Groups to create dropdown
                for (int i = 0; i < lstGroups.size(); i++)
                {
                	select = "";
                    if (openGrp.getId() == lstGroups.get(i).getId()) {
                		//Select current value (if none selected yet, all values will be "" with none selected)
                    	select = "selected";
                	} //end if
                  	//Use Group ID for value, and Group Name for text to show in dropdown
                  	out.println("<option value='"+lstGroups.get(i).getId()+"'"+select+">"+lstGroups.get(i).getName()+"</option>");
                } //end for
                %>
			</select> 
		</div>	
		
<!--SUBMIT FORM BUTTONS-->
		<div class="sameLine leftPadding">
			<input type="submit" value="Open Group" name="opengroup" id="submit">
		</div>

</fieldset>
</form>
<!--END FORM-->

<br><br>

<fieldset>

  <table id="openGroupTable">
	<tr>
	<td rowspan="2">
	
	<h3>View or Edit Group</h3>
	
	<!--START FORM-->
	<form id="newGroupForm" method="post" action="http://localhost:8080/RealityUWeb/NewGroupServlet" onSubmit="return validate(this);">
	
<%
                    //String obj 'newGroupMsg' created in NewGroupServlet
                    //Display msg only if new group data submitted
                    if (session.getAttribute("editGroupMsg") != null) {
                        HttpSession ses = request.getSession();
                        String msg = (String)ses.getAttribute("editGroupMsg");
                        out.println("<h2 id='newGroupMsg' class='smallerMsg'>"+msg+"</h2>");                  
                    } //end if              
%>	
	
	<div>
		<% 
		//If dupe Group Name when edited, show message
		//Key: id -1=dupe group name (Edited Group)
		if (openGrp.getId() == -1) { 
		%>
		<span class="inputErrorMsg">THIS GROUP NAME ALREADY USED. PLEASE RE-TRY</span><br><br>
		<% } //end if %>
		<label for="name">Group Name:</label>
		<input type="text" name="name" value="<%=openGrp.getName()%>">
	</div>
	<div>
		<label for="highschool">High School:</label>
		<input type="text" name="highschool" value="<%=openGrp.getHighschool()%>">
	</div>
	<div>
		<label for="teacher">Teacher:</label>
		<input type="text" name="teacher" value="<%=openGrp.getTeacher()%>">
	</div>
	<div>
		<label for="classPeriod">Periods:</label>
		<input type="text" name="classPeriod" value="<%=openGrp.getClassPeriod()%>">
	</div>
	<div>
		<label for="surveyStartDate">Survey Start Date:</label>
		<input type="text" name="surveyStartDate" value="<%=openGrp.getSurveyStartDate()%>">
	</div>
	<div>
		<label for="surveyEndDate">Survey End Date:</label>
		<input type="text" name="surveyEndDate" value="<%=openGrp.getSurveyEndDate()%>">
	</div>	
	
	<div>
		<label for="eventDate">Event Date:</label>
		<input type="text" name="eventDate" value="<%=openGrp.getEventDate()%>">
	</div>
	<div>
		<label for="studentAccessCode">Student Access Code:</label>
		<input type="text" name="studentAccessCode" value="<%=openGrp.getStudentAccessCode()%>" readonly>
	</div>
	
	<!-- Submit pageID so know which page came from -->
	<input type="hidden" name="pageID" value="opengroup">
	
<!--SUBMIT FORM BUTTONS-->
	<div id="formButtonsContainer" class="leftPadding">			
		<% 
		//If not a dupe Group Name, and a Group has been initially selected to view/edit, show "Edit Group" button
		//Key: id -1=dupe group name (when Edited Group)
		if (session.getAttribute("openGrp") != null) { 
		%>
			<input type="submit" value="Edit Group" id="submit" name="editGroup">
		<% } else { //if a Group not selected yet, disable the button %>
			<input type="submit" value="Edit Group" id="submit" name="submit" disabled>
		<% } //end if %>			
	</div>	
	
	<!--END FORM-->
	</form>	
	</td>
	
	<td>
<!-- NESTED FIELDSET - PROCESS/PRINT BUTTONS-->
	<fieldset id="processBtnsBox">	
	<!--START FORM-->
	<form id="newGroupForm" method="post" action="http://localhost:8080/RealityUWeb/ProcessAllSurveysServlet">
	
	<!--SUBMIT FORM BUTTONS-->
		<div id="formButtonsContainer">
		  <div id="formButtons">
		  	<!-- SEND GROUP ID TO SERVLET TO IDENTIFY GROUP -->
	  		<input type="hidden" name="groupID" value="<%=openGrp.getId()%>">
			<input type="submit" value="Process Surveys" id="submit" name="submit">
			<input type="submit" value="Print All Surveys" id="clear" name="print">	
		  </div>
		</div>	
	
	<!--END FORM-->
	</form>
	</fieldset>
	
	</td>	
	</tr>
	
	<tr>
	<td>
<!-- NESTED FIELDSET - STUDENT SURVEYS-->
	<fieldset id="groupSurveyBox">
	<h3>Student Surveys</h3>
	
	<%
	//Loop thru list of all Surveys to create list of all Surveys displayed
	//List of Surveys for selected Group created at top of page
    for (int i = 0; i < lstSurveys.size(); i++)
    {
    	out.println("<div>" + (i+1) + ". " + lstSurveys.get(i).getFname() + " " + lstSurveys.get(i).getLname());
    	//Start Form
    	//Add Survey ID to form fields to pass to servlet
				//out.println("<input type='hidden' name='surveyID' value='" + lstSurveys.get(i).getId() + "'>");
    %>
	  <!--START FORM-->
	  <form id="grpSurveyForm" method="post" action="http://localhost:8080/RealityUWeb/ManageSurveysServlet" onSubmit="return checkFunction(this);">
	  	<!-- SEND SURVEY ID & GROUP ID TO SERVLET TO IDENTIFY SURVEY/GROUP -->
	  	<input type="hidden" name="surveyID" value="<%=lstSurveys.get(i).getId()%>">	  	
		<!--SUBMIT FORM BUTTONS-->
		<div id="formButtonsContainer">
		  <div id="formButtons">
			<input type="submit" value="View/Edit" name="view" id="view" onclick="btn='submit';">
			<input type="submit" value="Print" name="print" id="print" onclick="btn='print';window.print();return false;">
			<input type="submit" value="Delete" name="delete" id="delete" onclick="btn='delete';">
			<%
            //Add buttons to view Processed Surveys if surveys processed
            //Check if processed via "isProcessed" flag set on servlet, or if Job field is filled in --> it's processed
            	//System.out.println("Outside IsProcessed = "+isProcessed+", Job is: "+lstSurveys.get(i).getJob());
            if (isProcessed != null || (!(lstSurveys.get(i).getJob().equals("")) && lstSurveys.get(i).getJob() != null)) {               
               	//Display buttons to view Processed Surveys
               	out.println("<input type='submit' value='Processed' name='processed' id='processed' onclick='btn=\"processed\";'>"); 
            } //end if
			%>
			
			
		  </div>
		</div>
	  </form>
	</div>
	<br>
	<%
	} //end for
	%>
	
	</fieldset>
	
	</td>
	</tr>
  </table>
	
	

</fieldset>

<br>



<br><br>

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

