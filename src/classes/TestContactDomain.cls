@isTest
public class TestContactDomain {
    static List<Account> accountList=new List<Account>();
    static List<Account> dupliAccountList=new List<Account>();
    static List<Contact> conList =new List<Contact>(); 
      
    //Test method 1:Data with all valid values    
    public static testMethod void testContactDomain() { 
        Account acc = new Account();
        accountList = TestDatafactory.accountData(40);
        insert accountList;     
                 
        conList = TestDatafactory.contactData(40); 
        Test.startTest();
            insert conList; 
        Test.stopTest();  
        
        for(Contact contactInstance : [SELECT LastName,Email,AccountId,Domain__c
                                       FROM Contact
                                       WHERE AccountId =:acc.Id])                        
        system.assertEquals(acc.Id,contactInstance.AccountId);
    }
    //Test method 2:Data with duplicate value of account
    public static testMethod void duplicateWebsite() {
        Account acc = new Account();
        accountList = TestDatafactory.accountData(40);
        insert accountList;   
                 
        for(Account accInstance: accountList) {
            
            Account acctObj = new Account();
            acctObj.Website = accInstance.Website;
            dupliAccountList.add(acctObj);
        }         
        conList = TestDatafactory.contactData(40); 
        Test.startTest();
            insert conList;
        Test.stopTest(); 
        
        for(Contact contactInstance : [SELECT LastName,Email,AccountId,Domain__c
                                       FROM Contact
                                       WHERE AccountId =:acc.Id])                        
        system.assertEquals(acc.Id,contactInstance.AccountId);
    }
    //Test method 3:Data with different website of account
    public static testMethod void missmatchWebsite() {
        Account acc = new Account();
        accountList = TestDatafactory.accountData(40);
        insert accountList;   
                 
        conList = TestDatafactory.contactData2(40); 
        Test.startTest();
            insert conList;
        Test.stopTest();  
        
        for(Contact contactInstance : [SELECT LastName,Email,AccountId,Domain__c
                                       FROM Contact
                                       WHERE AccountId =:acc.Id])                        
        system.assertEquals(acc.Id,contactInstance.AccountId);
    }
    //Test method 3:Data having no contact of account
    public static testMethod void nullWebsite() {
        Account acc = new Account();
        accountList = TestDatafactory.accountData(40);
        insert accountList;   
                 
        for(Account accInstance: accountList) {
            
            Account acctObj = new Account();
           
            dupliAccountList.add(acctObj);
        }         
        conList = TestDatafactory.contactData(40); 
        Test.startTest();
            insert conList;
        Test.stopTest(); 
        
        for(Contact contactInstance : [SELECT LastName,Email,AccountId,Domain__c
                                       FROM Contact
                                       WHERE AccountId =:acc.Id])                        
        system.assertNotEquals(acc.Id,contactInstance.AccountId);
    }
}