/****************************************************************************
 Class Name: notHavingBillingStateMaharashtraKerala
 Created Date:14/7/2015
 Description:This class shows record not having Maharashtra and kerala
					as billing state
*****************************************************************************/ 
public with sharing class notHavingBillingStateMaharashtraKerala {
    
	public void not_billing_state()
	{
		list<Account> listacc= [select Id,
                                 		name,
                                 		Billing_State__c
                                 from account
                                 where Billing_State__c
                                 NOT IN('Maharashtra','Kerala')
                                 ORDER by Billing_state__c
                                 DESC nulls last limit 1000];
		if(listacc!=null && listacc.size()>0){
		  system.debug(listacc);
		}
		else{
		    system.debug('Records not found');
		}
    }
}