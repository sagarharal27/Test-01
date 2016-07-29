/************************************************************************
 Class Name: lead_status
 Created Date:11/1/2015
 Description: This class changes the lead status to Status Changed
*************************************************************************/ 
public class changing_lead_status {
    public void displayChangedLead(){
    List<Lead> LeadList = [Select Id, Name, Status FROM Lead WHERE Status = 'Closed - Not Converted'];
    System.debug(LeadList);
	for(Lead Lobj : LeadList){
		Lobj.Status = 'Status changed';
        }
        Update LeadList;
        System.debug(LeadList);
    }
}