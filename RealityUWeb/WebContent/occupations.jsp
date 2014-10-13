<%--*******************************************************************
 *	RealityUWeb: occupatiions.jsp
 *  04/24/2014
 *******************************************************************--%>
 
<%@page import="dao.OccupationsDAO"%>
<%@page import="obj.Occupation"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
 
<%
//RESET ALL SESSION OBJECTS TO NULL TO CLEAR OUT VALUES
obj.Group grpp = null;
List<obj.Survey> lstSurvs = null;
Occupation ocp = null;
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
	//DON'T CLEAR FOR THIS PAGE
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

 //Declare variables Occupations
 List<Occupation> lstOccupation = new ArrayList<Occupation>();
 OccupationsDAO occp = new OccupationsDAO();
 //Get list of all Occupations from dbase
 lstOccupation = occp.findAllOccupations();
%>
 
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

<title>Communities In Schools - Reality U Admin Edit Occupations</title>
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
		#box1 {width: 200px;}
		#box2 {width: 200px;}
		#box3 {width: 200px;}		
		
		/*OR COULD TAKE BACKGRD IMAGE AWAY ENTIRELY*/
		/*#box1 {background-image: none;}*/
	</style>
<![endif]-->


<script type="text/javascript">
  //======================== CHECK SURVEY BUTTON FUNCTION ===========================
	//Value of 'btn' set via onclick on submit buttons at end of form
	var btn = "";
    function checkFunction(myform) {
    	if (btn == "delete") {
    		//Confirm if want to delete
    		var result = confirm("Are you sure you want to permanently delete this occupation?");
    		//Remove so doesn't open in new window
    		myform.removeAttribute('target');
    		return result;
    	} else { 
    		//Submit Button (Add Occupation or Edit Occupation)
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
<h3>Edit Occupations</h3>
</fieldset>

<br><br>

<div id="mainArea">
<br>
<br>

<!--START FORM-->
<form id="manageOccupsForm" method="post" action="http://localhost:8080/RealityUWeb/EditOccupationServlet" onSubmit="return checkFunction(this);">

<fieldset>
<br><br>


<%
                    //String obj 'occupsMsg' created in Servlet
                    //Display msg only if Occupation data submitted
                    if (session.getAttribute("occupsMsg") != null) {
                        HttpSession ses = request.getSession();
                        String msg = (String)ses.getAttribute("occupsMsg");
                        out.println("<h2 id='newGroupMsg'>"+msg+"</h2>");                  
                    } //end if              
%> 



 	<table>
 			<tr>
	                <th>ID</th>
	                <th>Occupation Name</th>
	                <th>Type</th>
	                <th>Industry</th>
	                <th>Category</th>
	                <th>Annual Gross Salary</th>
	                <th>Monthly Gross Salary</th>
	                <th>Married Annual Taxes</th>
	                <th>Married Monthly Taxes</th>
	                <th>Married After Taxes</th>
	                <th>Single Annual Taxes</th>
	                <th>Single Monthly Taxes</th>
	                <th>Single After Taxes</th>
	                <th>GPA Category</th>
	                <th>Education Loan</th>
	                <th>Edit</th>
	                <th>Delete</th>
                
            </tr>       

 		<%	
 				String bgColor = "";
                //Loop thru list of all ArrayList for list of all Occupations
                for (int i = 0; i < lstOccupation.size(); i++)
                { 	
                	
                	//Change background color of every other row
                	if((i%2) == 0) { //even numbers
                		bgColor = "#1e3583";
                	} else { //odd nums
                		bgColor = "#112360";
                	}	
                	
                  out.println("<tr style='background-color: "+bgColor+"'>");
                  
                  out.println("<td>"+ lstOccupation.get(i).getId() +"</td>");
                  out.println("<td>" + lstOccupation.get(i).getName()+ "</td>");
                  out.println("<td>"+lstOccupation.get(i).getType() +"</td>");
                  
                  out.println("<td>"+ lstOccupation.get(i).getIndustry() +"</td>");
                  out.println("<td>" + lstOccupation.get(i).getCategory()+ "</td>");
                  out.println("<td>$"+lstOccupation.get(i).getAnnGrossSal() +"</td>");
                  
                  out.println("<td>$"+ lstOccupation.get(i).getMonGrossSal() +"</td>");
                  out.println("<td>$" + lstOccupation.get(i).getMarAnnualTax()+ "</td>");
                  out.println("<td>$"+lstOccupation.get(i).getMarMonthlyTax() +"</td>");
                  
                  out.println("<td>$"+ lstOccupation.get(i).getMarAfterTax() +"</td>");
                  out.println("<td>$" + lstOccupation.get(i).getSinAnnualTax()+ "</td>");
                  out.println("<td>$"+lstOccupation.get(i).getSinMonthlyTax() +"</td>");
                  out.println("<td>$"+ lstOccupation.get(i).getSinAfterTax() +"</td>");
                  out.println("<td>" + lstOccupation.get(i).getGpaCategory()+ "</td>");
                  out.println("<td>$"+lstOccupation.get(i).getLoan() +"</td>");
                  out.println("<td><input type='submit' value='Edit' class='edit' name='edit_" + lstOccupation.get(i).getId() + "' onclick='btn=\"submit\";'></td>");
                  out.println("<td><input type='submit' value='Delete' class='delete' name='delete_" + lstOccupation.get(i).getId() + "' onclick='btn=\"delete\";'></td>");
                  out.println("</tr>");              
                } //end for
        %>


	</table>
	
</fieldset>

<br>

<!--SUBMIT FORM BUTTONS-->
		<div id="formButtonsContainer">
		  <div id="formButtons">
		  	<input type="submit" value="Add Occupation" id="submit" name="submit" onclick="btn='submit';">
		  </div>
		</div>

<br><br>

<!--END FORM-->
</form>


</div><!--END mainArea-->



</div><!--END Main-->


<!--FOR STICKY FOOTER-->
<div id="push"></div>


</div><!--END Content Wrapper-->


<!--FOOTER OUTSIDE WRAPPER-->
<div id="footer" class="legal">
Copyright &copy; 2009-2014 CIS of Marietta/Cobb County
</div><!--END FOOTER-->


</body>
</html>
