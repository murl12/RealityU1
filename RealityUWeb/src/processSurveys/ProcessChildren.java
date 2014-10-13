package processSurveys;
/****************************************************************************************************
 * This class retrieves the surveys of married women with and without children.
 * It then, based as much as possible on preference, assigns 50% of married women and their spouses
 *  needs to update after team is finish 
 *	RealityUWeb: ProcessChildren.java
 *  10/5/2014
 *  updated by 
 *  upload to github 10/11/2014
 ********************************************************************/

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

//import obj.Group;
import obj.Survey;
import dao.SurveysDAO;
//import ctrl.Controller;




public class ProcessChildren {
	
	
	private SurveysDAO sd = new SurveysDAO();
	
	private List<Survey> marriedFemalesList = new ArrayList<>();

	private List<Survey> marriedFemalesWithChildrenList = new ArrayList<>();

	private List<Survey> marriedFemalesWithNoChildrenList = new ArrayList<>();

	//private List<Survey> marriedMaleList = new ArrayList<>();
	
	//private  Survey spouseSurvey ;
	
	private double marriedWithChildrenLimitRatio = .5; // target is 50% or .5

	private double actualChildrenRatio;
	private double actualNoChildrenRatio;
	
	/**
	 * Random generators for selecting random surveys and number of children to
	 * add to survey
	 **/
	private Random randomGenerator = new Random();
	private int randomInteger;
	private int randomKids;


	public List<Survey> doProcess(List<Survey> surveysList) {

		System.out.println("Entering ProcessChildren.doProcess() method.");
		//clearList();
		// Clear out our list and counters
		marriedFemalesList.clear();
        System.out.println(surveysList.size());
		for (Survey survey : surveysList) {

			// Get surveys for all married women in group
			if (survey.getGender().equals("Female")&& survey.getMarried().equals("Yes")) {
				marriedFemalesList.add(survey);
				
				// If survey has children add to list married women with
				// children
				// Count surveys with children
				if (survey.getChildren().equals("Yes")) {
					marriedFemalesWithChildrenList.add(survey);
					
					// make sure the spouse has the same number of kids
					//spouseSurvey = spouseSurvey.getSurvey("id", 		
					//		Integer.toString(survey.getSpouse()));
					//spouseSurvey.setChildren(survey.getChildren());
				}
				
				// If survey has NO children add to list married with no
				// children
				// Count surveys without children
				else 
					//marriedFemalesWithNoChildrenList.add(survey);
				//}
					if (survey.getChildren().equals("No")) {
						marriedFemalesWithNoChildrenList.add(survey);		}
			}// end if female and married
		} // end for loop
		
        
		// Get percentages of married women with and without children
		actualChildrenRatio = (double) marriedFemalesWithChildrenList.size()
				/ marriedFemalesList.size();
		actualNoChildrenRatio = (double) marriedFemalesWithNoChildrenList
				.size() / marriedFemalesList.size();
		

		// If more than 50% of women have children we need to adjust down
		if (actualChildrenRatio > marriedWithChildrenLimitRatio) {
			adjustChildrenDown();
		}
		// If more than 50% of women have NO children we need to adjust up
			if (actualNoChildrenRatio > marriedWithChildrenLimitRatio) {
				adjustChildrenUp();
			}
		// end else
			
		System.out.println("Leaving ProcessChildren.doProcess() method.");
		System.out.println("-------------------------\n");
		return surveysList;		
		
	} // end doProcess()

	public void adjustChildrenDown() {

		/*
		 * While our percentage of married WITH kids is too high we randomly
		 * select married women with kids and take her children away.
		 * ^Let us know how that works out, huh?  ;-)
		 */
		while ((double) marriedFemalesWithChildrenList.size()
				/ marriedFemalesList.size() > marriedWithChildrenLimitRatio) {

			randomInteger = randomGenerator
					.nextInt(marriedFemalesWithChildrenList.size());

			Survey survey = marriedFemalesWithChildrenList.get(randomInteger);
			survey.setChildren("No");
			survey.setNumChild(0);
			sd.update(survey);
			marriedFemalesWithChildrenList.remove(survey);
			marriedFemalesWithNoChildrenList.add(survey);
			
			
		} // end while loop

	} // end adjustChildrenDown()

	public void adjustChildrenUp() {
		
		/*
		 * While our percentage of married with NO kids is too high we randomly
		 * select a married women with NO kids and give her children
		 */
		while ((double) marriedFemalesWithNoChildrenList.size()
				/ marriedFemalesList.size() > marriedWithChildrenLimitRatio) {
			randomInteger = randomGenerator.nextInt(marriedFemalesWithNoChildrenList.size());

			Survey survey = marriedFemalesWithNoChildrenList.get(randomInteger);

			// Randomly assign 1 or 2 kids
			randomKids = randomGenerator.nextInt(2) + 1;
            survey.setChildren("Yes");
			survey.setNumChild(randomKids);
			marriedFemalesWithNoChildrenList.remove(survey);
			marriedFemalesWithChildrenList.add(survey);
			
		} // end while loop
	}// end adjustChildrenUp()
	
	
	public static void main(String args[]){
		ProcessChildren pc = new ProcessChildren();
		//List<Survey> SurveysList = new ArrayList<Survey>();
		List<Survey> surveysList = new ArrayList<>();
		SurveysDAO sd = new SurveysDAO();
		surveysList = sd.search("groupID", "1");
		surveysList = pc.doProcess(surveysList);
		System.out.println(pc.marriedFemalesWithChildrenList.size());
		System.out.println(pc.marriedFemalesWithNoChildrenList.size());
		System.out.println(pc.marriedFemalesList.size());
		//System.out.println(pc.marriedMaleList.size());
		
			
	}//end main

} // end class
