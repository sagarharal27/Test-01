/************************************************************************
 Class Name: TestDuplicationOfLead
 Created Date:8/8/2015
 Description: This test class checks duplication of lead record
*************************************************************************/  
@isTest
public class TestDuplicationOfLead {
    
    static List<Lead> leadList = new List<Lead>(); 
    static List<Lead> leadDupliList = new List<Lead>(); 
    //Test method to which checks duplication of Lead
    static testMethod void avoidDuplicationOfLead() {
        
        leadList = TestDatafactory.leadData(5);         
        insert leadList;
        
        Test.startTest();   
            avoidDuplicationOfLead deleteInstance = new avoidDuplicationOfLead();
            Database.executeBatch(deleteInstance);
        Test.stopTest();
        
        leadDupliList = TestDatafactory.leadData(1);
        insert leadDupliList;
        
        //Getting list of leads with same email id
        List<Lead> getLeadList = new List<Lead>();
        getLeadList = [SELECT Id,LastName,Email
                          FROM Lead
                          where Email = 'p@eternussolutions.com'];
        System.assertEquals(2,getLeadList.size());
    }
    //Test method to accepts different record of Lead
    static testMethod void differentRecordOfLead() {
        
        leadList = TestDatafactory.leadData(5);         
        
        Test.startTest();   
        avoidDuplicationOfLead deleteInstance = new avoidDuplicationOfLead();
        Database.executeBatch(deleteInstance);
        Test.stopTest();
        
        leadDupliList=TestDatafactory.leadDiffData(5);
        insert leadDupliList;
        
        System.assertEquals(5,leadDupliList.size());
    }
}