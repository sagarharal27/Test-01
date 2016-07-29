@isTest
public class BatchProcessing {

    static testMethod void testOpportunity() {
               
         List<Account> accList = new List<Account>();
         List<Opportunity> oppList = new List<Opportunity>();
         
         for(Integer i=0;i<5;i++ ) {
             Account testAccount = new Account(Primary_Contact__c = 'Pooja'+i+'@eternussolutions.com',
                                Name = 'Pooja'+i,Email_ID__c='test'+i+'.jadhav@eternussolutions.com');
            accList.add(testAccount); 
        } 
        insert accList;
        
        for(Integer i=0;i<5;i++ ){  
            Opportunity testOppTemp = new Opportunity(Amount = 30,Name = 'Pooja' +i,
                                  CloseDate = (Date)Date.today() ,
                                  AccountId = accList[0].Id,StageName  = 'Closed Won');
            oppList.add(testOppTemp);
        }
        insert oppList;
        
        Database.executeBatch(new CollectionOfClosedOpportunity ()); 
        system.assertEquals(0,Limits.getEmailInvocations());
    }
       
         
      /* List<Account> accountList = new List<Account>();
        Account accountInstance = new Account();
        accountList=TestDatafactory.accountData(10);
        insert accountList; 
        
        List<Opportunity> oppList = new List<Opportunity>();
        Opportunity oppInstance = new Opportunity();
        oppList=TestDatafactory.oppData(10);
        insert oppList;  
        
        Opportunity testopp = new Opportunity(Amount = 30,Name = 'Pooja' , CloseDate = (Date)Date.today() , AccountId = accountList[0].Id,StageName  = 'Closed Won');
        oppList.add(testopp);
        insert oppList;
        
        Database.executeBatch(new CollectionOfClosedOpportunity ()); 
       
        system.assertequals(0,Limits.getEmailInvocations());*/
}