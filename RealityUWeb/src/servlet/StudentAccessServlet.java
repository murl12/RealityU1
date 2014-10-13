package servlet;
/********************************************************************
 *	RealityUWeb: StudentAccessServlet.java
 *  3/19/2014
 ********************************************************************/
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;

import obj.Group;
import dao.GroupsDAO;
import obj.Survey;
import dao.SurveysDAO;

/**
 * Servlet implementation class StudentAccessServlet
 * Student Access process. Validate Student Access Code given
 * and then check if matches existing student last name & dob. If it 
 * matches, the survey has already been completed and they cannot edit -> go to message page.
 * If name/dob doesn't match, they go to Survey page. 
 * If Student Access Code is invalid, they go to invalid login page.
 */
@WebServlet("/StudentAccessServlet")
public class StudentAccessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentAccessServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    //   ==========================  processRequest() Method  ============================
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Declare Variables
        String lastName;
        String DofB;
        String studentAccesscode;
        List<Group> lstGrp = new ArrayList<Group>();
        Group grp = new Group();
        List<Survey> lstSurvey = new ArrayList<Survey>();
        Survey surv = new Survey();  
        Survey s1 = null; //reset survey session object so doesn't use previous survey info on new form
        String surveyMsg = null; //Reset to null for new form so msg doesn't show up
        
        try {
            //Read in Form Data & Cleanup
        	studentAccesscode = cleanupString(request.getParameter("accesscode"));		
        	lastName = cleanupString(request.getParameter("lName"));
        	DofB = cleanupString(request.getParameter("dob"));
            System.out.println("Read in Form Data.");
            
            //Create GroupsDAO & Group Objs and search for matching access code in dbase
            GroupsDAO gd = new GroupsDAO();
            System.out.println("Created GroupsDAO obj.");
            //Returns List of Groups matching search criteria (even if only 1)
            lstGrp = gd.search("studentAccessCode", studentAccesscode); //Lookup by access code          
            System.out.println("Acquired List of Group objs. Num matches for Access Code: " + lstGrp.size());
            
            //Validate Student Access Code
            if (lstGrp.size() == 1) { //1=valid access code match found
            	//If access code is valid, check lastName/DofB for matches           	
            	
                //Create SurveysDAO & Survey Objs and Validate Login
                SurveysDAO surv1 = new SurveysDAO();
                System.out.println("Created SurveysDAO obj.");
                
                //Search for matches by DOB (date of birth)
                //Returns List of Surveys matching search criteria
                lstSurvey = surv1.search("dob", DofB);  
                System.out.println("Acquired List of Survey objs. Num matches DOB: " + lstSurvey.size());
                
                if (lstSurvey.size() == 0) {
                	//Valid Login - No dob match, so student has not completed a Survey
                	
                	//Put Group Obj and Strings for Last Name & DOB in Session
                	grp = lstGrp.get(0); //First and only obj in list is index 0
            		System.out.println("Extracted Group obj from List.");
            		HttpSession ses1 = request.getSession();
            		ses1.setAttribute("grp", grp);
            		ses1.setAttribute("lastName", lastName);
            		ses1.setAttribute("DofB", DofB);
            		ses1.setAttribute("s1", s1); //Reset to null for new form
            		ses1.setAttribute("surveyMsg", surveyMsg); //Reset to null for new form
            		System.out.println("Group: "+grp.getName()+", Last Name: "+lastName+" & DOB: "+DofB+" added to Session.");
            		System.out.println("surveyMsg: "+ surveyMsg);
                	grp.display();

                	//Forward to Survey page 
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/survey.jsp");
                    rd.forward(request, response);
                    System.out.println("Yay! Valid Student Access.");
                	
                } else {
                	//Found dob match. Search for Last Name match. (Both must match)
                	
                	int flag = 0;
	                //Loop thru Survey List (could be multiple objs in list if dupe bdays)
	                for (int i = 0; i < lstSurvey.size(); i++)
	                {
	            		surv = lstSurvey.get(i);
	            		System.out.println("Extracted Survey obj " + i + " from List.");
	            		surv.display();
	            		
	            		if (surv.validateLogin(DofB, lastName)) {
	            			//Combined match on name/dob: Student has already completed a survey 
	                        flag = 1;
	                        System.out.println("Flag changed to: " + flag);
	                        //End loop
	                        break;
	            		} //end if
	                		
	                } //end for*/
                	
	                if (flag == 1) {
            			//Combined match on name/dob: Student has already completed a survey
            			//Forward to Message Page - no access to survey
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/studentNoAccess.jsp");
                        rd.forward(request, response);
                        System.out.println("INVALID: Student has already completed survey.");
	                	
	                } else {
	                	//No match on Last Name so Student can complete new Survey
	                	
	                	//Put Group Obj and Strings for Last Name & DOB in Session
	                	grp = lstGrp.get(0); //First and only obj in list is index 0
	            		System.out.println("Extracted Group obj from List.");
	            		HttpSession ses1 = request.getSession();
	            		ses1.setAttribute("grp", grp);
	            		ses1.setAttribute("lastName", lastName);
	            		ses1.setAttribute("DofB", DofB);
	            		ses1.setAttribute("s1", s1); //Reset to null for new form
	            		ses1.setAttribute("surveyMsg", surveyMsg); //Reset to null for new form
	            		System.out.println("Group: "+grp.getName()+", Last Name: "+lastName+" & DOB: "+DofB+" added to Session.");
	            		System.out.println("surveyMsg: "+ surveyMsg);
	                	grp.display();
	                	
	                	//Forward to Survey page 
	                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/survey.jsp");
	                    rd.forward(request, response);
	                    System.out.println("Yay! Valid Student Access.");
	                	
	                } //end if flag
	                
                } //end if 
	            
                
            } else {
            	//Access Code invalid - Forward to Error Page
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/invalidLogin.jsp");
                rd.forward(request, response);
                System.out.println("ERROR! Access Code Invalid.");
            }//End if
            
            
        } catch (Exception e) {
			// Handle Errors
			System.out.println("Error: " + e);
        } //end try
    } //end processRequest
    
    /**
     * Cleanup the String parameter by replacing null with an
     * empty String (if null), or by trimming whitespace from non-null Strings.
     * Return the cleaned up String.
     */
    private String cleanupString(String str) {
        return (str != null) ? str.trim() : "";
    }
    
    //   ==========================  doGet() Method  ============================
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//Calls processRequest() Method
        processRequest(request, response);
    } //end doGet
	
//  ==========================  doPost() Method  ============================
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//Calls processRequest() Method
        processRequest(request, response);
    } //end doGet
	

}


