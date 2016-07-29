/************************************************************************
 Class Name: TestStudentForm
 Created Date:8/8/2015
 Description: This test class performs test for student objects
*************************************************************************/  
@isTest
public class TestStudentForm {
    static ApexPages.StandardController StandardControllerExtension = 
                    new ApexPages.StandardController(new Student__c());
    
    //Test Method to check save function of record
    static testMethod void testSaveRecordBulk() {
        
        List<Student__c> studList = new List<Student__c>();
<<<<<<< HEAD
        for (integer i = 0; i < 20; i++) {
=======
         for (integer i = 0; i < 20; i++) {
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
            Student__c studentInstance = new Student__c(Student_Name__c = 'test'+i);
            studList.add(studentInstance);
         }
         
        Test.StartTest();
        for(integer i = 0; i < studList.Size(); i++) {
            ApexPages.StandardController standardController = 
                new ApexPages.StandardController(studList[i]);
            StudentRegistrationExtension studentExtensionInstance = 
                new StudentRegistrationExtension(standardController);
            studentExtensionInstance.saveRecord();
        }
        Test.StopTest();
        
        List<Student__c> studentList = new List<Student__c>();
        studentList = [SELECT id 
                       FROM Student__c 
                       WHERE Student_Name__c LIKE 'test%'];
        System.assertEquals(20,studentList.size());
    }
    
    static testMethod void testSaveRecordMessage() {
        
        List<Student__c> studList = new List<Student__c>();
        for (integer i = 0; i < 20; i++) {
            Student__c studentInstance = new Student__c(Student_Name__c = 'test');
            studList.add(studentInstance);
        }
        
        Test.StartTest();
        for(integer i = 0; i < studList.Size(); i++) {
            ApexPages.StandardController standardController = 
                new ApexPages.StandardController(studList[i]);
            StudentRegistrationExtension studentExtensionInstance = 
                new StudentRegistrationExtension(standardController);
            studentExtensionInstance.saveRecord();
        }
        Test.StopTest();
        
        ApexPages.Message[] msgs=ApexPages.getMessages();
        system.assertEquals(1,msgs.Size());  
        
    }
    
    //Test method to check functionality of language
    public static testMethod void getlanguage() {
        StudentRegistrationExtension studInstance = new StudentRegistrationExtension
                                                    (StandardControllerExtension);
        List<SelectOption> optionList = new List<SelectOption>();
        optionList = studInstance.getlanguageList();
        System.assertEquals(3,optionList.size()); 
    }
     static testMethod void testErrorInSaveRecord() {
        
        Student__c studentInstance = new Student__c(Student_Name__c = ' ');
        insert studentInstance;
            
        StudentRegistrationExtension studInstance = new StudentRegistrationExtension
                                                        (StandardControllerExtension);
        studInstance.saveRecord();
        
        ApexPages.Message[] msgs=ApexPages.getMessages();
         system.assertEquals(1,msgs.Size());  
    }
    
}