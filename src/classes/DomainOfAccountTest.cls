@isTest
private class DomainOfAccountTest {
    //Domain of email matches with the website
    static testMethod void domainOfAccount() {
        Account acc = new Account();
        acc.Name='Eternus';
        acc.Website='www.gmail.com';
        insert acc;
        
        Contact con = new Contact();
        con.LastName='Jadhav';
        con.Email='p@gmail.com';
        
        Test.startTest();
        insert con;
        Test.stopTest();  
        for(Contact contactInstance : [SELECT LastName,Email,AccountId,Domain__c
                                       FROM Contact
                                       WHERE AccountId =:acc.Id])                        
        system.assertEquals(acc.Id,contactInstance.AccountId);
    }
    //domain of email does not match with the website
    static testMethod void domainNotMatch() {
        Account acc = new Account();
        acc.Name='Eternus';
        acc.Website='www.gmail.com';
        insert acc;
        Contact con = new Contact();
        con.LastName='Jadhav';
        con.Email='p@yahoo.com';
        
        Test.startTest();
        insert con;
        Test.stopTest();  
        for(Contact contactInstance : [SELECT LastName,Email,AccountId,Domain__c
                                       FROM Contact
                                       WHERE AccountId =:acc.Id])                        
        system.assertEquals(acc.Id,contactInstance.AccountId);
    }
    // Email field of Conatct is blank
    static testMethod void nullEmail(){
        Account acc = new Account();
        acc.Name='Eternus';
        acc.Website='www.gmail.com';
        
        insert acc;
        Contact con = new Contact();
        con.LastName='Jadhav';
       
        Test.startTest();
        insert con;
        Test.stopTest();  
        for(Contact contactInstance : [SELECT LastName,Email,AccountId,Domain__c
                                FROM Contact
                                WHERE AccountId =:acc.Id])                        
        system.assertEquals(acc.Id,contactInstance.AccountId);
    }
    // Domain of Email is not known
    static testMethod void unknownDomain(){
        Account acc = new Account();
        acc.Name='Eternus';
        acc.Website='www.gmail.com';
        insert acc;
        Contact con = new Contact();
        con.LastName='Jadhav';
        con.Email='p@abc.com';
        Test.startTest();
        insert con;
        Test.stopTest();  
        for(Contact contactInstance : [SELECT LastName,Email,AccountId,Domain__c
                                FROM Contact
                                WHERE AccountId =:acc.Id])                        
        system.assertEquals(acc.Id,contactInstance.AccountId);
        
        
        // TO DO: implement unit test
    }
}