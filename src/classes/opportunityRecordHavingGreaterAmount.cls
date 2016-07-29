/****************************************************************************
 Class Name: opportunityRecordwithAmount
 Created Date:14/7/2015
 Description: This class displays record of opportunity having amount
				greater than 10000
*****************************************************************************/ 
public with sharing class opportunityRecordHavingGreaterAmount {
	public void displyaingRecordsHavingGreaterAmount() {
  		list<Opportunity> listacc= [select Id,name,Amount
                                 from Opportunity 
                                 where Amount >10000
                                 ORDER by CreatedDate
                                 ASC offset 50 all rows];
		//Null check for list
        if(listacc!=NULL && listacc.size()>0){
			system.debug(listacc);
        }
        else{
        	system.debug('Records not found');
        }
	}
}