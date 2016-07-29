@isTest
private class Clone_ofAccount_Record_TestClass {

    static testMethod void accountRecordClone() {
        Account objacc=new Account();
        
        objacc.Name='Test';
        objacc.Billing_State__c='Test';
        objacc.Industry='Media';
        
        Test.StartTest();
         insert objacc;
        Test.StopTest();
        
        list<Account> lstacc=[SELECT Id,name from Account where Name='Test'];
        
        system.assertEquals(2,lstacc.size());
        
        // TO DO: implement unit test
    }
}