<%--*******************************************************************
 *	RealityUWeb: surveyview.jsp
 *  04/16/2014
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
ses1.setAttribute("occupsMsg", mssg);
//For editoccups.jsp
ses1.setAttribute("editOccp", ocp);
ses1.setAttribute("editOccupsMsg", mssg);
//For surveyview.jsp
	//DON'T CLEAR FOR THIS PAGE
//For surveprocessed.jsp	
ses1.setAttribute("surveyprocessGrp", grpp);
ses1.setAttribute("processSurvey", survey);
ses1.setAttribute("surveyProcMsg", mssg);	

obj.Group grp =(obj.Group)session.getAttribute("surveyviewGrp");
obj.Survey surv =(obj.Survey)session.getAttribute("viewSurvey");

//Declare variables for String List of all Occupations to use in dropdowns
List<String> lstCategories = new ArrayList<String>();
OccupationsDAO oc = new OccupationsDAO();
lstCategories = oc.findAllCategories();
//Create List of Lists (Occupation Name String List inside Categories List) to use in Occupation dropdown
//Contains occup name values for every category possibility
List<List<String>> loccp = new ArrayList<List<String>>();
loccp = oc.findOccupationNamesPerCategory();

//If Group obj is null, create default Group obj with blank values to be used in form fields
if (grp == null) {
	grp = new obj.Group();
} //end if

//String obj 'lastName' is put in session in StudentAccessServlet
String lname = "";
if (session.getAttribute("lastName") != null) {
    HttpSession ses = request.getSession();
    lname = (String)ses.getAttribute("lastName");           
} //end if              

//String obj 'DofB' is put in session in StudentAccessServlet
String dob = "";
if (session.getAttribute("DofB") != null) {
    HttpSession ses = request.getSession();
    dob = (String)ses.getAttribute("DofB");             
} //end if

//String obj 'categoryIndustry' is put in session in SubmitSurveyServlet
String category = "";
if (session.getAttribute("categoryIndustry") != null) {
  HttpSession ses = request.getSession();
  category = (String)ses.getAttribute("categoryIndustry");             
} //end if
%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

<title>Communities In Schools - Reality U Survey</title>
<meta charset="utf-8">
<!--Edge = render site in highest standards mode possible 8, 9..., chrome = use Google engine if installed-->

<meta http-equiv="pragma" content="no-cache">

<link rel="stylesheet" href="css/reset.css" media="screen, print">
<link rel="stylesheet" href="css/mainstyles.css" media="screen, print">
<link rel="stylesheet" href="css/print.css" media="print">

<!--FOR STICKY FOOTER IN OLDER IE BROWSERS (except IE 7 OK)-->
<!--[if (lt IE 9) & (!(IE 7))]>
	<style type="text/css">
		#wrapper {display:table; height:100%;}
	</style>
<![endif]-->


<!-- FORM VALIDATION -->
<script type="text/javascript">

//======================== FORM VALIDATION ===========================
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
	        if(myform.dateofbirth.value == "") {
	            message += "- Date of Birth must be completed \n";
	            num = 1;
	        }
	        
	      	//RADIO BUTTON VALIDATION
            var g = "";
            //Loop thru each radio button, verify if "checked"
            for (var i=0; i<myform.gender.length; i++) {
                if (myform.gender[i].checked) {
                    //Changes value of "g" if a value is selected
                    g = myform.gender[i].value;
                }
            }
            //If no radio button selected, "g" will still = ""
            if (g == "") {
                message += "- Gender must be completed \n";
                num = 1;
            }
	
            //Dropdown
            if(myform.education.value == "") {
	            message += "- Education must be completed \n";
	            num = 1;
	        }
            //Dropdown
            if(myform.industry.value == "") {
	            message += "- Employment Industry must be completed \n";
	            num = 1;
	        }
            //Dropdown
            if(myform.occupation.value == "") {
	            message += "- Occupation must be completed \n";
	            num = 1;
	        }
            
          	//RADIO BUTTON VALIDATION
            var g = "";
            //Loop thru each radio button, verify if "checked"
            for (var i=0; i<myform.married.length; i++) {
                if (myform.married[i].checked) {
                    //Changes value of "g" if a value is selected
                    g = myform.married[i].value;
                }
            }
            //If no radio button selected, "g" will still = ""
            if (g == "") {
                message += "- Married must be completed \n";
                num = 1;
            }
            
          	//RADIO BUTTON VALIDATION
            var g = "";
            //Loop thru each radio button, verify if "checked"
            for (var i=0; i<myform.children.length; i++) {
                if (myform.children[i].checked) {
                    //Changes value of "g" if a value is selected
                    g = myform.children[i].value;
                }
            }
            //If no radio button selected, "g" will still = ""
            if (g == "") {
                message += "- Children must be completed \n";
                num = 1;
            }
            
          	//Dropdown
          	//Only require if previous field Children marked "Yes"
            if(myform.numchild.value == "0" && g == "Yes") {
	            message += "- Number of Children must be completed \n";
	            num = 1;
	        }
          	
          	//RADIO BUTTON VALIDATION
            var g = "";
            //Loop thru each radio button, verify if "checked"
            for (var i=0; i<myform.creditcard.length; i++) {
                if (myform.creditcard[i].checked) {
                    //Changes value of "g" if a value is selected
                    g = myform.creditcard[i].value;
                }
            }
            //If no radio button selected, "g" will still = ""
            if (g == "") {
                message += "- Credit Card must be completed \n";
                num = 1;
            }
            
          	//Dropdown
          	//Only require if previous field Credit Card marked "Yes"
            if(myform.cc_use.value == "" && g == "Yes") {
	            message += "- Credit Card Use must be completed \n";
	            num = 1;
	        }
          	//Dropdown
            if(myform.groceries.value == "") {
	            message += "- Groceries must be completed \n";
	            num = 1;
	        }
          	//Dropdown
            if(myform.clothing.value == "") {
	            message += "- Clothing must be completed \n";
	            num = 1;
	        }
          	
            if(myform.home.value == "") {
	            message += "- Home must be completed \n";
	            num = 1;
	        }
            if(myform.vehicle.value == "") {
	            message += "- Vehicle must be completed \n";
	            num = 1;
	        }
            if(myform.entertain.value == "") {
	            message += "- Entertainment must be completed \n";
	            num = 1;
	        }
          	
          	//Dropdown
            if(myform.save.value == "") {
	            message += "- Savings must be completed \n";
	            num = 1;
	        }
            
	        if (num == 1) { 
	            alert ("Please complete or correct the following required fields: \n\n"+message);

	            return false;
	        } else {
	        	
	            return true;
	            
	        } //end if
    	} //end if submit button
    	
    	if (btn == "delete") {
			//Confirm if want to delete
			var result = confirm("Are you sure you want to permanently delete this survey?");
			return result;
    	} //end if delete button
    	
    } //end func
    
    
  	//=============== TO DISABLE CCARDS AND NUMBER OF CHILDREN DROPBOXES ==================
  	function handleSelect(myRadio){
    	if(myRadio.value == "No"){
    		document.getElementById("cc_use").selectedIndex = 0; //reset to initial default value
    		document.getElementById("cc_use").disabled = true;		
    	} else {  		
    		document.getElementById("cc_use").disabled = false;
    	} //end if
    } //end func
    
    function handleSelect1(myRadio1){
    	if(myRadio1.value == "No"){
    		document.getElementById("numchild").selectedIndex = 0; //reset to initial default value
    		document.getElementById("numchild").disabled = true;  		
    	} else {   		
    		document.getElementById("numchild").disabled = false;
    	} //end if
    } //end func
    
    
    
    //=============== POPULATE OCCUPATION DROPDOWN BASED ON INDUSTRY DROPDOWN SELECTION ==================    
    function configureDropDownList(industry, occupation) { //params: id's of sending dropdown & dropdown to change
    	//Categories: Create a String value of all the list items in the Java ArrayList of Categories
    	//It translates into a String with opening and closing brackets: [], need to delete brackets from String
    	var categoryListString = "<%= lstCategories %>";
    	categoryListString = categoryListString.replace("[","");
    	categoryListString = categoryListString.replace("]","");   	
    	//Split the Category String into a new Javascript array of Categories
    	var categoryArray = new Array();
    	categoryArray = categoryListString.split(", "); //Make sure it's comma + space
    	
    	//Occupations: Create a String value of all the nested list items in the Java ArrayList of ArrayLists: all occup names for each category
    	//It translates into a String with opening and closing DOUBLE brackets: [[]], need to delete brackets from String
    	var occupByCatsString = "<%= loccp %>";
    	occupByCatsString = occupByCatsString.replace("[[","");
    	occupByCatsString = occupByCatsString.replace("]]","");
    	//Split the String into a new Javascript array
    	var occupationsArray = new Array();
    	occupationsArray = occupByCatsString.split("], [");
    	//Loop thru array and break into further individual nested arrays for occup names in each category
    	for (var i = 0; i < occupationsArray.length; i++) {
    		occupationsArray[i] = occupationsArray[i].split(", "); //Make sure it's comma + space
    	}
    		//alert("new occup name array index 0: "+occupationsArray[0]+", index 1: "+occupationsArray[1]);
    		//alert("Individ occup names in index 0, name 0: "+occupationsArray[0][0]+", name 1: "+occupationsArray[0][1]);

    	//Categories array (categoryArray) & Nested Occup Names Array by Category (occupationsArray)
    	//are parallel arrays in order to match Category names with appropriate group of Occup Names
    	
    	//Loop thru list of all Categories to find selected one
    	//and create dropdown list of matching Occup Names for that Category
        for (var i = 0; i < categoryArray.length; i++)
        {
        	if (industry.value == categoryArray[i]) {
        	//Call method to create Occupation dropdown list values
        	//Send array of that Category's list of Occupation Names as parameter, and 'occupation' id value of select
        	createOccupationItems(occupationsArray[i], occupation);
        	}
        } //end for
    } //end function
    
    function createOccupationItems(occupArr, occupation) {
    	//Parameters in: array of that Category's list of Occupation Names, and 'occupation' id value of select
    	document.getElementById(occupation).options.length = 0; 
    	for (var i = 0; i < occupArr.length; i++) {
        	createOption(document.getElementById(occupation), occupArr[i], occupArr[i]);
        }
    } //end function

    function createOption(ddl, text, value) {
        var opt = document.createElement('option');
        opt.value = value;
        opt.text = text;
        ddl.options.add(opt);
    } //end function
    

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
<div id="nav" class="noprint">
  <ul>
  	<li><a href="index.jsp">Home</a></li>	
	<li><a href="adminhome.jsp">Admin Home</a></li>
	<li><a href="newgroup.jsp">New Group</a></li>
    <li><a href="opengroup.jsp">Open Group</a></li>
	<li><a href="editoccups.jsp">Edit Occupations</a></li>
    <li><a href="helpadmin.html">Help</a></li>
  </ul>
</div><!--END NAVIGATION-->


</div><!--END HEADER-->




<!--MAIN CONTENT CONTAINER -->
<div id="main">

<br><br class="noprint">

<fieldset>
<h3>Student Survey <span class="eventDate">&mdash; Reality U Event Date: <%=grp.getEventDate()%></span></h3>
</fieldset>

<br><br class="noprint">


<div id="mainArea">

<fieldset class="noprint">
<h3>Directions</h3>
<p>Think about your future, and answer these questions as though you are 26 years old.</p>
</fieldset>

<br class="noprint"><br class="noprint">

<!--START FORM-->
<form id="surveyForm" method="post" action="http://localhost:8080/RealityUWeb/SubmitSurveyServlet" onSubmit="return validate(this);">

<%
                    //String obj 'surveyMssg' created in SubmitSurveyServlet
                    //Display msg only if survey data submitted
                    if (session.getAttribute("surveyMssg") != null) {
                        HttpSession ses = request.getSession();
                        String msg = (String)ses.getAttribute("surveyMssg");
                        out.println("<h2 id='newGroupMsg'>"+msg+"</h2>");                  
                    } //end if              
%> 

<!--***************************** Start Survey Page**************************-->
<fieldset>
<h3>Class Information</h3>
<br class="noprint">
			<div class="sameLine">
				<label for="groupName">Group Name:</label>
				<input type="text" name="groupName" value="<%=grp.getName()%>" readonly>
			</div>
			<div class="sameLine">
				<label for="teacher">Teacher:</label>
				<input type="text" name="teacher" value="<%=grp.getTeacher()%>" readonly>
			</div>
			<div class="sameLine">
				<label for="period">Class Period:</label>
				<input type="text" name="period" value="<%=grp.getClassPeriod()%>" readonly>
			</div>
</fieldset>

<br><br class="noprint">

<fieldset>
<h3>Student Information</h3>
<br class="noprint">

<!--
			<div>
				<label for="studentid">ID:</label>
				<input type="text" name="studentid">
			</div>
			<br>
-->			
			<div class="sameLine">
				<label for="firstname">First Name:</label>
				<input type="text" name="firstname" value="<%=surv.getFname()%>">
			</div>
			<div class="sameLine">
				<label for="lastname">Last Name:</label>
				<input type="text" name="lastname" value="<%=surv.getLname()%>">
			</div>
			<div class="sameLine">
				<label for="dateofbirth">Date Of Birth:</label>
				<input type="text" name="dateofbirth" value="<%=surv.getDob()%>">
			</div>

			<%
                String c0, c1;
                if (surv.getGender().equals("Male")) {
                    c0 = "checked";  //Checked value for Male
                    c1 = ""; //Value for Female not "checked"
                } else { //if value is "Female"
                    c0 = "";  //Value for Male not "checked"
                    c1 = "checked"; //Check value for Female
                }
        	%>    
            <div class="radioInput">
                <label for="gender">Gender:</label>
                <div><input type="radio" name="gender" value="Male" <%=c0%>>Male</div>
                <div><input type="radio" name="gender" value="Female" <%=c1%>>Female</div>
            </div>
			
			<br>
			
			<div>
				<label for="gpa">Current GPA:</label>
				<input type="text" name="gpa" value="<%=surv.getGpa()%>">
			</div>	
	
<!-- 			
			<div>
				<label for="gpa">Current GPA:</label> 
				<select name="gpa">
					<option value="0">====Select From List====</option>
					<option value="1">Under 1.5</option>
					<option value="2">1.5-1.9</option>
					<option value="3">2.0-2.4</option>
					<option value="4">2.5-2.9</option>
					<option value="5">3.0-3.4</option>
					<option value="6">3.5-4.0</option>
				</select> 
			</div>
-->

</fieldset>

<br><br class="noprint">

<fieldset>
<h3>Future Expected Education & Employment</h3>
<br class="noprint">	
		<%
				//Create array to hold dropdown values
				String[] dropDownValues = new String[7];
				dropDownValues[0] = "";
				dropDownValues[1] = "High School";
				dropDownValues[2] = "On-The-Job Training";
				dropDownValues[3] = "Community College";
				dropDownValues[4] = "Technical School";
				dropDownValues[5] = "Some College, Bachelor's Degree";
				dropDownValues[6] = "College + Graduate School";
		%>
		<div>
			<label for="education">Planned Education:</label> 
			<select name="education" >
		<%
				//Loop thru array of dropdown values to create dropdown
				//and mark the selected value
				String select;
		        for (int i = 0; i < dropDownValues.length; i++)
		        {
		          select = "";
		          if (surv.getEducation().equals(dropDownValues[i])) {
		              //Select current value
		              select = "selected";
		          } //end if
		          if (i == 0) {
		        	  //Set value of default item
		        	  out.println("<option value='"+dropDownValues[i]+"'"+select+">=======Select From List=======</option>");
		          } else {
		        	  //Escape double quotes on this one due to value with a single quote in it "Bachelor's" (error w/ single quotes)
		        	  out.println("<option value=\""+dropDownValues[i]+"\""+select+">"+dropDownValues[i]+"</option>");
		          } //end if  
		        } //end for
        %>			
			</select> 
		</div>		
		<br>
		<div>
			<label for="industry">Preferred Employment Industry:</label> 
			<select name="industry" id="industry" onchange="configureDropDownList(this,'occupation')">
				<option value="">=======Select From List=======</option>  
                <%                
                //Loop thru list of all Categories to create dropdown
                //and mark the selected value
                int catIndex = 0; //Set value of category index to create 'occupation' dropdown below
                for (int i = 0; i < lstCategories.size(); i++)
                {
				  select = "";
                  if (category.equals(lstCategories.get(i))) {
                      //Select current value
                      select = "selected";
                      //Set value of category index to create 'occupation' dropdown below
                      catIndex = i;
                  } //end if
                  out.println("<option value='"+lstCategories.get(i)+"'"+select+">"+lstCategories.get(i)+"</option>");
                }
                %>
            </select> 
		</div>	
		<br>
		<div>
			<label for="occupation">Occupation:</label>
			<select name="occupation" id="occupation">
				<%
				//Use 'catIndex' to loop thru occupation name values for that specific category in
                //arrayList 'loccp' to create dropdown and mark the selected value
                for (int i = 0; i < loccp.get(catIndex).size(); i++)
                {
				  select = "";
                  if (surv.getPrefJob().equals(loccp.get(catIndex).get(i))) {
                      //Select current value
                      select = "selected";
                  } //end if
                  out.println("<option value='"+loccp.get(catIndex).get(i)+"'"+select+">"+loccp.get(catIndex).get(i)+"</option>");
                }
                %>		
			</select> 
		</div>		
</fieldset>

<br><br class="noprint">

<fieldset>
<h3>Future Expected Family Information</h3>
<br class="noprint">

		<%
                if (surv.getMarried().equals("Yes")) {
                    c0 = "checked";  //Checked value for Yes
                    c1 = ""; //Value for No not "checked"
                } else { //if value is "No"
                    c0 = "";  //Value for Yes not "checked"
                    c1 = "checked"; //Check value for No
                }
        %>     
		<div class="radioInput">
			<label for="married">Married:</label>
			<div><input type="radio" name="married" value="Yes" <%=c0%>>Yes</div>
			<div><input type="radio" name="married" value="No" <%=c1%>>No</div>
		</div>
		<br>

		<%
                if (surv.getChildren().equals("Yes")) {
                    c0 = "checked";  //Checked value for Yes
                    c1 = ""; //Value for No not "checked"
                } else { //if value is "No"
                    c0 = "";  //Value for Yes not "checked"
                    c1 = "checked"; //Check value for No
                }
        %>
		<div class="radioInput sameLine">
			<label for="children">Children:</label> 
			<div><input type="radio" name="children" value="Yes" onchange="handleSelect1(this)" <%=c0%>>Yes</div>
			<div><input type="radio" name="children" value="No" onchange="handleSelect1(this)" <%=c1%>>No</div>
		</div>

		<div class="sameLine">
			<label for="numchild">Number of Children:</label> 
			<select name="numchild" id="numChild">
		<%
				//Loop thru array of dropdown values to create dropdown
				//and mark the selected value
		        for (int i = 0; i <= 5; i++)
		        {
		          select = "";
		          if (surv.getNumChild() == i) {
		              //Select current value
		              select = "selected";
		          } //end if
		          if (i == 0) {
		        	  //Set value of default item
		        	  out.println("<option value='"+i+"'"+select+">=======Select From List=======</option>");
		          } else {
		          	  out.println("<option value='"+i+"'"+select+">"+i+"</option>");
		          } //end if
		        } //end for
        %>			
			</select>
		</div>
		
</fieldset>

<br><br class="noprint">

<fieldset id="spendingSection">
<h3>Future Expected Spending Habits</h3>
<br class="noprint">
		<%
                if (surv.getCCards().equals("Yes")) {
                    c0 = "checked";  //Checked value for Yes
                    c1 = ""; //Value for No not "checked"
                } else { //if value is "No"
                    c0 = "";  //Value for Yes not "checked"
                    c1 = "checked"; //Check value for No
                }
        %>
		<div class="radioInput sameLine">
			<label for="creditcard">Credit Card:</label> 
			<div><input type="radio" name="creditcard" value="Yes" onchange="handleSelect(this)" <%=c0%>>Yes</div>
			<div><input type="radio" name="creditcard" value="No" onchange="handleSelect(this)" <%=c1%>>No</div>
		</div>

		<%
				//Create array to hold dropdown values
				String[] dropDownValuesurv = new String[3];
				dropDownValuesurv[0] = "";
				dropDownValuesurv[1] = "Emergencies Only";
				dropDownValuesurv[2] = "Non-Emergencies";
		%>
		<div class="sameLine">
			<label for="cc_use">Credit Card Used For:</label>
			<select name="cc_use" id="cc_use">
		<%
				//Loop thru array of dropdown values to create dropdown
				//and mark the selected value
		        for (int i = 0; i < dropDownValuesurv.length; i++)
		        {
		          select = "";
		          if (surv.getCCardUses().equals(dropDownValuesurv[i])) {
		              //Select current value
		              select = "selected";
		          } //end if
		          if (i == 0) {
		        	  //Set value of default item
		        	  out.println("<option value='"+dropDownValuesurv[i]+"'"+select+">=======Select From List=======</option>");
		          } else {
		        	  out.println("<option value='"+dropDownValuesurv[i]+"'"+select+">"+dropDownValuesurv[i]+"</option>");
		          } //end if
		        } //end for
        %>			
			</select>  
		</div>
		
		<div class="clearFloat"></div>

		<%
				//Use array values for both Grocs & Cloth fields
				//Create array to hold dropdown values
				String[] dropDownValues3 = new String[4];
				dropDownValues3[0] = "";
				dropDownValues3[1] = "Low-Priced";
				dropDownValues3[2] = "Moderately-Priced";
				dropDownValues3[3] = "High-Priced";
		%>
		<div class="sameLine">
			<label for="groceries">When you buy Groceries, will you buy mostly:</label> 
			<select name="groceries">
		<%
				//Loop thru array of dropdown values to create dropdown
				//and mark the selected value
		        for (int i = 0; i < dropDownValues3.length; i++)
		        {
		          select = "";
		          if (surv.getGroceries().equals(dropDownValues3[i])) {
		              //Select current value
		              select = "selected";
		          } //end if
		          if (i == 0) {
		        	  //Set value of default item
		        	  out.println("<option value='"+dropDownValues3[i]+"'"+select+">=======Select From List=======</option>");
		          } else {
		        	  out.println("<option value='"+dropDownValues3[i]+"'"+select+">"+dropDownValues3[i]+"</option>");
		          } //end if
		        } //end for
        %>			
			</select>
		</div>
				
		<div class="clearFloat"></div>
				
		<div class="sameLine">
			<label for="clothing">When you buy Clothing, will you buy mostly:</label> 
			<select name="clothing">
		<%
				//Loop thru array of dropdown values to create dropdown
				//and mark the selected value
		        for (int i = 0; i < dropDownValues3.length; i++)
		        {
		          select = "";
		          if (surv.getClothing().equals(dropDownValues3[i])) {
		              //Select current value
		              select = "selected";
		          } //end if
		          if (i == 0) {
		        	  //Set value of default item
		        	  out.println("<option value='"+dropDownValues3[i]+"'"+select+">=======Select From List=======</option>");
		          } else {
		        	  out.println("<option value='"+dropDownValues3[i]+"'"+select+">"+dropDownValues3[i]+"</option>");
		          } //end if
		        } //end for
        %>			
			</select>
		</div>	

		<div class="sameLine">
				<label for="home">What kind of Home will you live in:</label>
				<input type="text" name="home" value="<%=surv.getHome()%>">
		</div>
		<div class="sameLine">
				<label for="vehicle">What kind of Vehicle will you drive:</label>
				<input type="text" name="vehicle" value="<%=surv.getVehicle()%>">
		</div>
		<div class="sameLine">
				<label for="entertain">What will you do for Entertainment:</label>
				<input type="text" name="entertain" value="<%=surv.getEntertainment()%>">
		</div>
		
		<%
				//Create array to hold dropdown values
				String[] dropDownValues4 = new String[6];
				dropDownValues4[0] = "";
				dropDownValues4[1] = "Under $25";
				dropDownValues4[2] = "$26-$100";
				dropDownValues4[3] = "$101-$500";
				dropDownValues4[4] = "$501-$1,000";
				dropDownValues4[5] = "Over a $1,000";
		%>
		<div class="sameLine">
			<label for="save">How much will you Save each month:</label> 
			<select name="save">
		<%
				//Loop thru array of dropdown values to create dropdown
				//and mark the selected value
		        for (int i = 0; i < dropDownValues4.length; i++)
		        {
		          select = "";
		          if (surv.getSave().equals(dropDownValues4[i])) {
		              //Select current value
		              select = "selected";
		          } //end if
		          if (i == 0) {
		        	  //Set value of default item
		        	  out.println("<option value='"+dropDownValues4[i]+"'"+select+">=======Select From List=======</option>");
		          } else {
		        	  out.println("<option value='"+dropDownValues4[i]+"'"+select+">"+dropDownValues4[i]+"</option>");
		          } //end if
		        } //end for
        %>					
			</select> 
		</div>
		
		<!-- Submit SurveyID if form edited -->
		<input type="hidden" name="surveyID" value="<%=surv.getId()%>">
		<!-- Submit groupID if form edited -->
		<input type="hidden" name="groupID" value="<%=grp.getId()%>">
		<!-- Submit pageID to process differently for Admin (vs. Student) -->
		<input type="hidden" name="pageID" value="adminSurveyEdit">
		
</fieldset>

<!--***************************** End Survey Page**************************-->



<br class="noprint">

<!--SUBMIT FORM BUTTONS-->
		<div id="formButtonsContainer" class="noprint">
		  <div id="formButtons">
		  	<% 
			//If new Survey has been created, show "Edit Survey" button
			//Set value of javascript 'btn' variable via onclick to detect which button submitted
			//for different behavior for clear button & edit button
			if (session.getAttribute("viewSurvey") != null) { 
			%>
				<input type="submit" value="Edit Survey" id="submit" name="editSurvey" onclick="btn='submit';">
			<% } else { //if Survey not created yet %>
				<input type="submit" value="Submit" id="submit" name="submit" onclick="btn='submit';">
			<% } //end if %>
			<!-- KEPT ID AS 'clear' FOR CSS -->
			<input type="submit" value="Delete Survey" id="clear" name="delete" onclick="btn='delete';">
			
			<input type="button" value="Print Survey"  id="print" name="print" onclick="window.print();return false;">
			<!-- <input type="submit" value="Print" id="print" name="print" onclick="btn='print';"> -->
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