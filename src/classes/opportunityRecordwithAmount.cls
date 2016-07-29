/****************************************************************************
 Class Name: opportunityRecordwithAmount
 Created Date:14/7/2015
 Description: This class displays record of opportunity having amount
				greater than 10000
*****************************************************************************/ 
public with sharing class opportunityRecordwithAmount 
{
  public void condition_on_amount()
  {
  	list<Opportunity> listacc1= [select Id,name,Amount
                                 from Opportunity
                                 where Amount >10000
                                 ORDER by CreatedDate
                                 ASC offset 2 all rows];
		
	system.debug(listacc1);
  }
}