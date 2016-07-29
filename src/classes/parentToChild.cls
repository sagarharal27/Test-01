/****************************************************************************
 Class Name: parentToChild
 Created Date:14/7/2015
 Description: This class performs Parent to child .
*****************************************************************************/ 


public class parentToChild {
        
    public void ClosedWonOpportunity(){        
        list<account> lstaccount=[Select a.Name, a.Id,
                                  (Select Id, StageName From Opportunities) 
                                  From Account a where  a.id IN
                                  (Select AccountId from Opportunity
                                  where StageName Like 'Closed Won')];
        System.debug(lstaccount); 
        }
      
   	public void recordHavingNameJohn() {
        
  //parent to child
       list<Account> Listaccount = [select a.Name,a.Id, (select Name from Contacts where Name Like '%John%') 
                              From Account a where a.Id IN
                              (Select AccountId from Contact where Name Like '%john%') ];
        for(Account acn:Listaccount) {
           system.debug(acn);
           for(contact con: acn.contacts){
          		system.debug(con); 
           }
        }
   }
	public void recordHavingJohnInchild() {
		list<A__c> myList = [Select a.Name, a.Id, (Select Name From C__r) 
                              From A__c a  
                              where  A__c.id IN
                             (Select C_to_A__c from C__c where Name Like '%john%')];
         for(A__c aobj:myList){
          	system.debug(aobj);
            	for(C__c cobj: aobj.C__r){
                	system.debug(cobj);
                }
          }
	}
}