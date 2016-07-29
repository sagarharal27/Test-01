/****************************************************************************
 Class Name: functionOnEnrollnment_year
 Created Date:14/7/2015
 Description: This class displays record of enrollnment year 2010
				and another method displays enrollnment year 2013 and 2014
*****************************************************************************/ 

public with sharing class functionOnEnrollnment_year{
    //method displays record of enrollnment year 2010
	public void countRecordOf2010(){
		list<Account> listacc=[select Id,name,phone from account where Enrollnment_Year__c='2010'];
		system.debug(listacc);
	}
	//method displays enrollnment year 2013 and 2014	
	public void countRecord2013and2013(){
		list<Account> listacc1=[select Id,name,phone from account where Enrollnment_Year__c INCLUDES('2013','2014')];
		system.debug(listacc1);
	}
}