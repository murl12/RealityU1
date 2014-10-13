package obj;

/********************************************************************
 *	RealityUWeb: Group.java
 *  3/21/2014
 ********************************************************************/
/**
 * The Class Group.
 */
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;



import dao.GroupsDAO;

public class Group {
    //   ========================== Properties ===========================
	/*********************************
	 * Declarations
	 ********************************/
	private int id;
	private String name;
	private String created; //change to date
	private String modified; //change to date
	private String highschool;
	private String teacher;
	private String classPeriod;  
	private String surveyStartDate; //change to date
	private String surveyEndDate; //change to date
	private String eventDate; //change to date
	private String studentAccessCode;
	//List of all Group id's
    private ArrayList<String> allGroupIds = new ArrayList<String>();

	//   ==========================  Constructors  ========================
	/**
	 * Default Constructor
	 */
	public Group() {
		this.id = 0;
		this.name = "";
		this.created = "";
		this.modified = "";
		this.highschool = "";
		this.teacher = "";
		this.classPeriod = "";  
		this.surveyStartDate = "";
		this.surveyEndDate = "";
		this.eventDate = "";
		this.studentAccessCode = "";
	}

	/**
	 * Constructor with all parameters
	 * 
	 * @param id
	 * @param name
	 * @param created
	 * @param modified
	 * @param highschool
	 * @param teacher
	 * @param classPeriod 
	 * @param surveyStartDate
	 * @param surveyEndDate
	 * @param eventDate
	 * @param studentAccessCode
	 */
	public Group(int id, String name, String created, String modified, String highschool, 
			String teacher, String classPeriod, String surveyStartDate, String surveyEndDate,
			String eventDate, String studentAccessCode) {
		this.id = id;
		this.name = name;
		this.created = created;
		this.modified = modified;
		this.highschool = highschool;
		this.teacher = teacher;
		this.classPeriod = classPeriod;  
		this.surveyStartDate = surveyStartDate;
		this.surveyEndDate = surveyEndDate;
		this.eventDate = eventDate;
		this.studentAccessCode = studentAccessCode;
	}
	
	/**
	 * Constructor with all parameters except studentAccessCode
	 * which is automatically generated via the generateStudentAccessCode() method
	 * 
	 * @param id
	 * @param name
	 * @param created
	 * @param modified
	 * @param highschool
	 * @param teacher
	 * @param classPeriod 
	 * @param surveyStartDate
	 * @param surveyEndDate
	 * @param eventDate
	 */
	public Group(int id, String name, String created, String modified, String highschool, 
			String teacher, String classPeriod, String surveyStartDate, String surveyEndDate,
			String eventDate) {
		this.id = id;
		this.name = name;
		this.created = created;
		this.modified = modified;
		this.highschool = highschool;
		this.teacher = teacher;
		this.classPeriod = classPeriod;  
		this.surveyStartDate = surveyStartDate;
		this.surveyEndDate = surveyEndDate;
		this.eventDate = eventDate;
		//Use method to generate random access code
		this.studentAccessCode = generateStudentAccessCode();
	}

	//   ==========================  Behaviors  ==========================
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}	

    /**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the created
	 */
	public String getCreated() {
		return created;
	}

	/**
	 * @param created the created to set
	 */
	public void setCreated(String created) {
		this.created = created;
	}

	/**
	 * @return the modified
	 */
	public String getModified() {
		return modified;
	}

	/**
	 * @param modified the modified to set
	 */
	public void setModified(String modified) {
		this.modified = modified;
	}

	/**
	 * @return the highschool
	 */
	public String getHighschool() {
		return highschool;
	}

	/**
	 * @param highschool the highschool to set
	 */
	public void setHighschool(String highschool) {
		this.highschool = highschool;
	}

	/**
	 * @return the teacher
	 */
	public String getTeacher() {
		return teacher;
	}

	/**
	 * @param teacher the teacher to set
	 */
	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	/**
	 * @return the classPeriod
	 */
	public String getClassPeriod() {
		return classPeriod;
	}

	/**
	 * @param classPeriod the classPeriod to set
	 */
	public void setClassPeriod(String classPeriod) {
		this.classPeriod = classPeriod;
	}

	/**
	 * @return the surveyStartDate
	 */
	public String getSurveyStartDate() {
		return surveyStartDate;
	}

	/**
	 * @param surveyStartDate the surveyStartDate to set
	 */
	public void setSurveyStartDate(String surveyStartDate) {
		this.surveyStartDate = surveyStartDate;
	}

	/**
	 * @return the surveyEndDate
	 */
	public String getSurveyEndDate() {
		return surveyEndDate;
	}

	/**
	 * @param surveyEndDate the surveyEndDate to set
	 */
	public void setSurveyEndDate(String surveyEndDate) {
		this.surveyEndDate = surveyEndDate;
	}

	/**
	 * @return the eventDate
	 */
	public String getEventDate() {
		return eventDate;
	}

	/**
	 * @param eventDate the eventDate to set
	 */
	public void setEventDate(String eventDate) {
		this.eventDate = eventDate;
	}

	/**
	 * @return the studentAccessCode
	 */
	public String getStudentAccessCode() {
		return studentAccessCode;
	}

	/**
	 * @param studentAccessCode the studentAccessCode to set
	 */
	public void setStudentAccessCode(String studentAccessCode) {
		this.studentAccessCode = studentAccessCode;
	}
	
	/**
	 * @return the allGroupIds
	 */
	public ArrayList<String> getAllGroupIds() {
		return allGroupIds;
	}

	/**
	 * @param allGroupIds the allGroupIds to set
	 */
	public void setAllGroupIds(ArrayList<String> allGroupIds) {
		this.allGroupIds = allGroupIds;
	}
    
    //   ========================  GENERATE RANDOM ALPHANUMERIC STUDENT ACCESS CODE  ====================
	/**
	 * Generates random Student Access Code, and checks for duplicates in dbase.
	 * 
	 * @param length
	 *            : Sets length of student access code
	 * @return Returns a String student access code.
	 */
	public String generateStudentAccessCode(int length){
			//Use numbers and only upper case letters in code
			String alphabet = new String("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ");
			int n = alphabet.length();

			String code = new String(); 
			Random r = new Random();

			//Loop set to 'length' to create code with that many characters
			for (int i=0; i<length; i++) {
				//Generate random character from alphabet
				code += alphabet.charAt(r.nextInt(n));
			} //end for
			System.out.println("Code = " + code);
			
			//Search dbase for match to code
			List<Group> lstGrp = new ArrayList<Group>();
			GroupsDAO gd1 = new GroupsDAO();
			lstGrp = gd1.search("studentAccessCode", code);
			System.out.println("Checked dbase for match to code (0=no match): " + lstGrp.size());
			if (lstGrp.size() != 0) {
            	//Invalid Code - Already used in dbase (found match)
				//Generate new code by calling itself (recursive)
				code = generateStudentAccessCode(length);
				System.out.println("Recursive Code = " + code);
			} //end if
		
			System.out.println("Final Returned Code = " + code);
			return code;
	} //end method
	/**
	 * Generates random Student Access Code, and checks for duplicates in dbase.
	 * Implements method overloading, no length parameter here. Length is set
	 * as default value of 8.
	 * 
	 * @return Returns a String student access code.
	 */
	public String generateStudentAccessCode(){
		//To use as default value for 'length' if don't want to set it
		int length = 8;
		//Use numbers and only upper case letters in code
		String alphabet = new String("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ");
		int n = alphabet.length();

		String code = new String(); 
		Random r = new Random();

		//Loop set to 'length' to create code with that many characters
		for (int i=0; i<length; i++) {
			//Generate random character from alphabet
			code += alphabet.charAt(r.nextInt(n));
		} //end for
		System.out.println("Code = " + code);
		
		//Search dbase for match to code
		List<Group> lstGrp = new ArrayList<Group>();
		GroupsDAO gd1 = new GroupsDAO();
		lstGrp = gd1.search("studentAccessCode", code);
		System.out.println("Checked dbase for match to code (0=no match): " + lstGrp.size());
		if (lstGrp.size() != 0) {
        	//Invalid Code - Already used in dbase (found match)
			//Generate new code by calling itself (recursive)
			code = generateStudentAccessCode(length);
			System.out.println("Recursive Code = " + code);
		} //end if
	
		System.out.println("Final Returned Code = " + code);
		return code;
} //end method
 
    //   ========================  DISPLAY METHOD  ====================        
	public void display() {
		System.out.println("GroupID\t\t\t= " + getId());
		System.out.println("Group Name\t\t= " + getName());
        System.out.println("Date Created\t\t= " + getCreated());
		System.out.println("Date Modified\t\t= " + getModified());
		System.out.println("High School\t\t= " + getHighschool());
		System.out.println("Teacher\t\t\t= " + getTeacher());
        System.out.println("Class Period\t\t= " + getClassPeriod());
		System.out.println("Survey Start Date\t= " + getSurveyStartDate());
		System.out.println("Survey End Date\t\t= " + getSurveyEndDate());
		System.out.println("Event Date\t\t= " + getEventDate());
		System.out.println("Student Access Code\t= " + getStudentAccessCode());
	} //end display()
      
    //   ========================  DISPLAY LIST METHOD  ====================
    /******************************************************
    * Display Group List: display id list for all Groups 
    *****************************************************/
   public void displayGroupList()
   {
       System.out.println("LIST OF GROUPS");
       System.out.println("---------------------------");
           for (int i = 0; i < allGroupIds.size(); i++)
           {
               System.out.println("GroupID "+i+"\t\t= " + allGroupIds.get(i));                    
               System.out.println("---------------------------");
           } //end for
   } //end displayGroupList

    //   ========================  MAIN METHOD  ==================== 
	public static void main(String[] args) {
		//Test generateAccessCdoe() method
		Group g = new Group();
		String a = g.generateStudentAccessCode();
		
		//Test Constructor with auto generated access code
		Group g2 = new Group(0, "a", "a", "a", "a", "a", "a", "a", "a", "a");
		g2.display();
	} //end main()
}

