/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
 
@isTest
public class StudentRegestration_Test {
    static ApexPages.StandardController StandardControllerExtension = 
        new ApexPages.StandardController(new Student__c());
    
    /**
     * Test the if student record is getting saved
     */
    public static testMethod void testStudenSaveRecord() {
        Student__c studentInstance = new Student__c();
        studentInstance.Name__c = 'test';
        studentInstance.Roll_No__c = 101;
        
        // New excution context
        Test.startTest();
        ApexPages.StandardController standardController = 
            new ApexPages.StandardController(studentInstance);
        StudentRegestrationController studentExtensionInstance = 
            new StudentRegestrationController(standardController);
        studentExtensionInstance.saveRecord();
        Test.stopTest();
        
        // Get list of student whos name is test
        List<Student__c> studentList = [
            SELECT 
                id 
            FROM 
                Student__c 
            WHERE 
                Name__c = 'test'
            ];
        
        // Check if the student record is inserted
        System.assertEquals(1, studentList.size());
    }
    
    /**
     * Test the getLanguage()
     */
    public static testMethod void testGetlanguage() {
        List<SelectOption> optionList;
        Student__c studentInstance = new Student__c();
        studentInstance.Name__c = 'test';
        studentInstance.Roll_No__c = 101;
        insert studentInstance;
        List<Language__c> languageList = new List<Language__c>();
        Language__c languageList1 = new Language__c(Name = 'English');
        Language__c languageList2 = new Language__c(Name = 'Spanish');
        Language__c languageList3 = new Language__c(Name = 'French');
        languageList.add(languageList1);
        languageList.add(languageList2);
        languageList.add(languageList3);
        insert languageList;
        
        // New excution contex
        Test.startTest();
        ApexPages.StandardController standardController = 
            new ApexPages.StandardController(studentInstance);
        StudentRegestrationController studentExtensionInstance = 
            new StudentRegestrationController(standardController);
         optionList = studentExtensionInstance.getallLanguage();
        Test.stopTest();
        
        // Check if the language picklist size is 4 (3 languages +1 select language option) 
        System.assertEquals(4, optionList.size()); 
    }
}