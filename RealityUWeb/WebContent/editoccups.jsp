<%--*******************************************************************
 *	RealityUWeb: editoccups.jsp
 *  04/24/2014
 *******************************************************************--%>
<%@page import="obj.Occupation"%>
<%@page import="dao.OccupationsDAO"%>
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
ses1.setAttribute("occupsMsg", mssg);
//For editoccups.jsp
	//DON'T CLEAR FOR THIS PAGE
//For surveyview.jsp
ses1.setAttribute("surveyviewGrp", grpp);
ses1.setAttribute("viewSurvey", survey);
ses1.setAttribute("surveyMssg", mssg);
//For surveprocessed.jsp	
ses1.setAttribute("surveyprocessGrp", grpp);
ses1.setAttribute("processSurvey", survey);
ses1.setAttribute("surveyProcMsg", mssg);

Occupation occp = (Occupation)session.getAttribute("editOccp");
//If form never been filled in yet, Occupation obj will be null so
//need to set all Occupation values to blank/empty by using default Occupation constructor
if (session.getAttribute("editOccp") == null) {
	occp = new Occupation(); //all values 0 or ""
}
//Get String List of all occupation Categories for dropdown
List<String> lstCategories = new ArrayList<String>();
OccupationsDAO oc = new OccupationsDAO();
lstCategories = oc.findAllCategories();

//Create List of Lists (Type & Industry String List inside Categories List)
//to use to fill in Type & Industry form fields basedon Category dropdown selection
//Contains Type & Industry values for every category possibility
List<List<String>> lstTypeAndIndustry = new ArrayList<List<String>>();
lstTypeAndIndustry = oc.findTypesAndIndustriesPerCategory();
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
	//Value of 'btn' set via onclick on submit/clear buttons at end of form
	var btn = "";
	
    function validate(myform) {
    	if (btn == "submit") {
       		//Validate Form only on 'submit' button (not for 'clear' button)
	        var num = 0;
	        var message = "";
	        if(myform.name.value == "") {
	            message += "- Occupation Name must be completed \n";
	            num = 1;
	        } 
	        if(myform.category.value == "") {
	            message += "- Category must be completed \n";
	            num = 1;
	        }
	        
/*	        
	        if(myform.type.value == "") {
	            message += "- Type must be completed \n";
	            num = 1;
	        }
	        if(myform.industry.value == "") {
	            message += "- Industry must be completed \n";
	            num = 1;
	        }
*/	        	        
	
	        if(myform.annGrossSal.value == "" || myform.annGrossSal.value == "0.0") {
	            message += "- Annual Gross Salary must be completed \n";
	            num = 1;
	        }
/*
	        if(myform.monGrossSal.value == "") {
	            message += "- Monthly Gross Salary must be completed \n";
	            num = 1;
	        }
	        if(myform.marAnnualTax.value == "") {
	            message += "- Marrried Annual Taxes must be completed \n";
	            num = 1;
	        }
	        if(myform.marMonthlyTax.value == "") {
	            message += "- Married Monthly Taxes must be completed \n";
	            num = 1;
	        }
	        if(myform.marAfterTax.value == "") {
	            message += "- Married After Taxes  must be completed \n";
	            num = 1;
	        }
	        if(myform.sinAnnualTax.value == "") {
	            message += "- Single Annual Taxes must be completed \n";
	            num = 1;
	        }
	        if(myform.sinMonthlyTax.value == "") {
	            message += "- Single Monthly Taxes must be completed \n";
	            num = 1;
	        }
	        if(myform.sinAfterTax.value == "") {
	            message += "- Single After Taxes must be completed \n";
	            num = 1;
	        }
*/	        
	        
	        if(myform.gpaCategory.value == "0") {
	            message += "- GPA Category must be completed \n";
	            num = 1;
	        }
	        if(myform.loan.value == "" || myform.loan.value == "0.0") {
	            message += "- Education Loan field must be completed \n";
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
    
    //=========== POPULATE TYPE & INDUSTRY FIELD VALUES BASED ON CATEGORY DROPDOWN SELECTION ==============    
    function configureDropDownList(category, type, industry) {
    	//Categories: Create a String value of all the list items in the Java ArrayList of Categories
    	//It translates into a String with opening and closing brackets: [], need to delete brackets from String
    	var categoryListString = "<%= lstCategories %>";
    	categoryListString = categoryListString.replace("[","");
    	categoryListString = categoryListString.replace("]","");   	
    	//Split the Category String into a new Javascript array of Categories
    	var categoryArray = new Array();
    	categoryArray = categoryListString.split(", "); //Make sure it's comma + space
    	
    	//Type & Industry: Create a String value of all the nested list items in the Java ArrayList of ArrayLists: Type & Industry for each category
    	//It translates into a String with opening and closing DOUBLE brackets: [[]], need to delete brackets from String
    	var typeAndIndustryString = "<%= lstTypeAndIndustry %>";
    	typeAndIndustryString = typeAndIndustryString.replace("[[","");
    	typeAndIndustryString = typeAndIndustryString.replace("]]","");
    	//Split the String into a new Javascript array
    	var typeAndIndustryArray = new Array();
    	typeAndIndustryArray = typeAndIndustryString.split("], [");
    	//Loop thru array and break into further individual nested arrays for type/industry in each category
    	for (var i = 0; i < typeAndIndustryArray.length; i++) {
    		typeAndIndustryArray[i] = typeAndIndustryArray[i].split(", "); //Make sure it's comma + space
    	}
    		//alert("new type/industry array index 0: "+typeAndIndustryArray[0]+", index 1: "+typeAndIndustryArray[1]);
    		//alert("Type 0: "+typeAndIndustryArray[0][0]+", Industry 1: "+typeAndIndustryArray[0][1]);

    	//Categories array (categoryArray) & Nested Type/Industry Array by Category (typeAndIndustryArray)
    	//are parallel arrays in order to match Category names with appropriate Type/Industry
    	
    	//Loop thru list of all Categories to find selected one
    	//and set form field values for Type & Industry for that Category
        for (var i = 0; i < categoryArray.length; i++)
        {
        	if (category.value == categoryArray[i]) {
        		//Set values for type and industry form fields to that Category's Type & Industry
        		document.getElementById(type).value = typeAndIndustryArray[i][0];
        		document.getElementById(industry).value = typeAndIndustryArray[i][1];
        	}
        } //end for
    } //end function
    
    
  	//============ POPULATE & CALCULATE SALARY & TAX FIELDS BASED ON GROSS SALARY ===============    
    function calculateSalaryTax(annualSalary) { //param: annual gross salary amount;
    	//Calculate Monthly Gross Salary
    	var monthlySalary = annualSalary / 12;
    	document.getElementById("monGrossSal").value = Math.round(monthlySalary * 100) / 100;
    	
    	//Calculate Married & Single Annual Taxes depending on salary amount
    	if (annualSalary <= 15000) {
    		marriedAnnualTax = Math.round((annualSalary * .14) * 100) / 100;
    		singleAnnualTax = Math.round((annualSalary * .16) * 100) / 100;
    	} else if (annualSalary <= 30000) {
    		marriedAnnualTax = Math.round((annualSalary * .20) * 100) / 100;
    		singleAnnualTax = Math.round((annualSalary * .22) * 100) / 100;
    	} else if (annualSalary <= 60000) {
    		marriedAnnualTax = Math.round((annualSalary * .28) * 100) / 100;
    		singleAnnualTax = Math.round((annualSalary * .32) * 100) / 100;
    	} else { //salary > 60000
    		marriedAnnualTax = Math.round((annualSalary * .34) * 100) / 100;
    		singleAnnualTax = Math.round((annualSalary * .36) * 100) / 100;
    	} //end if
    	document.getElementById("marAnnualTax").value = marriedAnnualTax;
		document.getElementById("sinAnnualTax").value = singleAnnualTax;
    	   	
    	//Calculate Monthly Married & Single Tax
    	var marriedMonthlyTax = Math.round((marriedAnnualTax / 12) * 100) / 100;
    	var singleMonthlyTax = Math.round((singleAnnualTax / 12) * 100) / 100;
    	document.getElementById("marMonthlyTax").value = marriedMonthlyTax;
    	document.getElementById("sinMonthlyTax").value = singleMonthlyTax;
    	
    	//Calculate Monthly Married & Single After Tax - Remaining Salary
    	var marriedAfterTax = Math.round((monthlySalary - marriedMonthlyTax) * 100) / 100;
    	var singleAfterTax = Math.round((monthlySalary - singleMonthlyTax) * 100) / 100;
    	document.getElementById("marAfterTax").value = marriedAfterTax;
    	document.getElementById("sinAfterTax").value = singleAfterTax;
    } //end func
    
 
  	//=============== REFRESH PAGE ==================    
	//REFRESH PARENT PAGE WHEN THIS ONE CLOSED TO 
	//UPDATE OCCUPATION TABLE WITH EDITED & NEW OCCUPATIONS
	window.onunload = refreshParent;
	function refreshParent() {
		window.opener.location.reload();
	}

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
<h3>Administration - Edit Occupation</h3>
</fieldset>



<br><br>

<div id="mainArea">

<!--START FORM-->
<form id="newGroupForm" method="post" action="http://localhost:8080/RealityUWeb/AddOccupationServlet" onSubmit="return validate(this);">

<%
                    //String obj 'editOccupsMsg' created in Servlet
                    //Display msg only if Occupation data submitted
                    if (session.getAttribute("editOccupsMsg") != null) {
                        HttpSession ses = request.getSession();
                        String msg = (String)ses.getAttribute("editOccupsMsg");
                        out.println("<h2 id='newGroupMsg'>"+msg+"</h2>");                  
                    } //end if              
%> 
<fieldset>
<br><br>

	<div>
		<label for="name">Occupation Name:</label>
		<input type="text" name="name" value="<%=occp.getName() %>">
	</div>
	
	
		<div>
			<label for="category">Select Occupation Category:</label>
			<select name="category" id="category" onchange="configureDropDownList(this,'type','industry')">			
				<%
                    //If adding new Occupation, id will = 0, so set default option as selected
                    if (occp.getId() == 0) {
                    	out.println("<option value='' selected>=======Select From List=======</option>");
                    } else { //if editing Occupation, it will have a value, so don't select default
                    	out.println("<option value=''>=======Select From List=======</option>");
                    } //end if              
               
                //Loop thru list of all Categories to create dropdown
                //and mark the selected value (none of them will be selected if adding new Occupation)
                String select;
                for (int i = 0; i < lstCategories.size(); i++)
                {
				  select = "";
                  if (occp.getCategory().equals(lstCategories.get(i))) {
                      //Select current value
                      select = "selected";
                  } //end if
                  out.println("<option value='"+lstCategories.get(i)+"'"+select+">"+lstCategories.get(i)+"</option>");
                }
                %>
            </select> 
		</div>
				
	<fieldset class="insetFieldset">	
		<p>Type and Industry will be completed automatically based on Category selected.</p>
		<div>
			<label for="type">Occupation Type:</label>
			<input type="text" name="type" id="type" value="<%=occp.getType()%>" readonly>
		</div>
		<div>
			<label for="industry">Industry:</label>
			<input type="text" name="industry" id="industry" value="<%=occp.getIndustry()%>" readonly>
		</div>	
	</fieldset>	
		
	

	<div>
		<label for="annGrossSal">Annual Gross Salary:</label>
		<input type="text" name="annGrossSal" id="annGrossSal" value="<%=occp.getAnnGrossSal()%>" onchange="calculateSalaryTax(this.value);">
	</div>

	<fieldset class="insetFieldset">	
		<p>These fields will be completed automatically based on the Annual Gross Salary.</p>	
		
		<div>
			<label for="monGrossSal">Monthly Gross Salary:</label>
			<input type="text" name="monGrossSal" id="monGrossSal" value="<%=occp.getMonGrossSal()%>" readonly>
		</div>	
		
		<div>
			<label for="marAnnualTax">Married Annual Taxes:</label>
			<input type="text" name="marAnnualTax" id="marAnnualTax" value=" <%=occp.getMarAnnualTax()%>" readonly>
		</div>
		<div>
			<label for="marMonthlyTax">Married Monthly Taxes:</label>
			<input type="text" name="marMonthlyTax" id="marMonthlyTax" value=" <%=occp.getMarMonthlyTax()%>" readonly>
		</div>
		<div>
			<label for="marAfterTax">Married After Taxes:</label>
			<input type="text" name="marAfterTax" id="marAfterTax" value=" <%=occp.getMarAfterTax() %>" readonly>
		</div>
		<div>
			<label for="sinAnnualTax">Single Annual Taxes:</label>
			<input type="text" name="sinAnnualTax" id="sinAnnualTax" value=" <%=occp.getSinAnnualTax() %>" readonly>
		</div>
		<div>
			<label for="sinMonthlyTax">Single Monthly Taxes:</label>
			<input type="text" name="sinMonthlyTax" id="sinMonthlyTax" value=" <%=occp.getSinMonthlyTax() %>" readonly>
		</div>
		<div>
			<label for="sinAfterTax">Single After Taxes:</label>
			<input type="text" name="sinAfterTax" id="sinAfterTax" value=" <%=occp.getSinAfterTax()%>" readonly>
		</div>		
	</fieldset>

		<%
				//Create array to hold dropdown values
				String[] dropDownValues = new String[7];
				dropDownValues[0] = "0";
				dropDownValues[1] = "Under 1.5 (GPA Category 1)";
				dropDownValues[2] = "1.5-1.9 (GPA Category 2)";
				dropDownValues[3] = "2.0-2.4 (GPA Category 3)";
				dropDownValues[4] = "2.5-2.9 (GPA Category 4)";
				dropDownValues[5] = "3.0-3.4 (GPA Category 5)";
				dropDownValues[6] = "3.5-4.0 (GPA Category 6)";				
		%>
	<div>
			<label for="gpaCategory">GPA Category:</label> 
			<select name="gpaCategory" id="gpaCategory">
		<%
				//Loop thru array of dropdown values to create dropdown
				//and mark the selected value
		        for (int i = 0; i < dropDownValues.length; i++)
		        {
		          select = "";
		          if (occp.getGpaCategory() == i) { //use 'i' for array index
		              //Select current value
		              select = "selected";
		          } //end if
		          if (i == 0) {
		        	  //Set value of default item
		        	  out.println("<option value='"+i+"'"+select+">=======Select From List=======</option>");
		          } else {		        	  
		        	  out.println("<option value='"+i+"'"+select+">"+dropDownValues[i]+"</option>");
		          } //end if  
		        } //end for
        %>			
			</select> 
	</div>
	
	<div>
		<label for="loan">Education Loan:</label>
		<input type="text" name="loan" value="<%=occp.getLoan() %>">
	</div>

</fieldset>



<br>

		<input type="hidden" name="occpsID" value="<%=occp.getId() %>">

<!--SUBMIT FORM BUTTONS-->
		<div id="formButtonsContainer">
		  <div id="formButtons">
		  	<% 
			//Set value of javascript 'btn' variable via onclick to detect which button submitted
			//for different behavior for clear button & edit button
			if (session.getAttribute("editOccp") != null) { 
			%>
				<input type="submit" value="Submit Changes" id="submit" name="editOccp" onclick="btn='submit';">
			<% } else { //if Occupation not created yet %>
				<input type="submit" value="Submit" id="submit" name="submit" onclick="btn='submit';">
			<% } //end if %>
			
			<input type="submit" value="Clear" id="clear" name="clear" onclick="btn='clear';">

		  </div>
		</div>


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