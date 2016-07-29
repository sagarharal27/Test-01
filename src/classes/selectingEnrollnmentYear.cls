/**************************************************************************************
 Class Name: selectingEnrollnmentYear
 Created Date:11/7/2015
 Description: This class displays Accounts having Enrollnment year as 2010,2013,2014
***************************************************************************************/ 

public class selectingEnrollnmentYear {
    
    
	public void accountPicklistOfTwoYear() {
	    List<Account> listAccount=new List<Account>(); 
	    
         listAccount= [Select a.Name, a.Id, a.Enrollnment_Year__c 
                              			From Account a 
                              			where a.EnrollnmentYear__c INCLUDES ('2013','2014') or a.EnrollnmentYear__c ='2010' ];
                              			
                              			system.debug(listAccount);
                              			
                              			
      /* if(listOftwoYears!=null && listOftwoYears.size()>0){
        	system.debug(listOftwoYears);
        }
        else{
            system.debug('Records not found');
        }
    }
        
       
	public void accountPicklistSingleTwoYear(){
    	list<Account> listOfsingleYear = [Select a.Name, a.Id, a.Enrollnment_Year__c 
                              			  From Account a 
                              			  where a.Enrollnment_Year__c ='2010' ];    
        if(listOfsingleYear!=null && listOfsingleYear.size()>0){
        	system.debug(listOfsingleYear);
        }
        else{
			 system.debug('Records not found');
        }
    }*/
}