/***************************************************************************************************
Class : TestRESTServiceProvider
Date : 23/8/2015
Description : This is test class for Rest service provider
****************************************************************************************************/
@isTest
private class TestRESTServiceProvider {
    static List<Lead> listLead = new List<Lead>() ;
    static List<Lead> leadListCheck = new List<Lead>() ;
    
    //Test for lead creation
    static testMethod void createLead() {
        listLead = TestDatafactory.leadData(10);
        insert listLead;
        RESTwebserviceForLead.createLead('Pooja','Jadhav','Open - Not Contacted',
                                         'Eternus','pooja@gmail.com','1111111');
        leadListCheck = [select id from Lead];
        System.assertEquals(11,leadListCheck.size());
    }
    //Test for failure of lead creation
    static testMethod void createLeadFail() {
        listLead = TestDatafactory.leadData(10);
        insert listLead;
        RESTwebserviceForLead.createLead('Pooja','','Open - Not Contacted',
                                         'Eternus','pooja@gmail.com','1111111');
        leadListCheck = [select id from Lead];
        System.assertEquals(10,leadListCheck.size());
    }
    // Test for Lead updation
    static testMethod void updateLead() { 
        listLead = TestDatafactory.leadData(10);
        insert listLead;
        RESTwebserviceForLead.leadUpdate('TestFirst','TestLast1','999999','p@yahoo.com');
        leadListCheck = [select id from Lead where Email = :'p@yahoo.com' ];
        System.assertEquals(1,leadListCheck.size()); 
    }
    // Test for failure of Lead updation
    static testMethod void updateLeadFail() {
        listLead = TestDatafactory.leadData(10);
        insert listLead;
        RESTwebserviceForLead.leadUpdate('TestFirst','TestLast1','abcdefg','999999');
        leadListCheck = [select id from Lead where Email = :'abcdefg'];
        System.assertEquals(0,leadListCheck.size());
    } 
    // Test for Lead deletion
    static testMethod void deleteLead() {
        
        RestContext.Request = new RestRequest();
        RestContext.Request.params.put('FirstName','Test');
        RestContext.Request.params.put('LatName','TestLat');
        RestContext.Request.params.put('Email','Test@gmail.com');
        RestContext.Request.params.put('Phone','12121212');
         
        RESTwebserviceForLead.deleteLead();
        leadListCheck = [select id from Lead];
        System.assertEquals(0,leadListCheck.size());
         
    }
}