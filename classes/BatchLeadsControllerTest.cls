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
private class BatchLeadsControllerTest {
    static testMethod void testCriteria() {
        List<DuplicateLeads__c> leadFields = new List<DuplicateLeads__c>();
        DuplicateLeads__c leadFields1 = new DuplicateLeads__c(Name = 'Name');
        DuplicateLeads__c leadFields2 = new DuplicateLeads__c(Name = 'Email');
        DuplicateLeads__c leadFields3 = new DuplicateLeads__c(Name = 'Phone');
        leadFields.add(leadFields1);
        leadFields.add(leadFields2);
        leadFields.add(leadFields3);
        insert leadFields;
        
        // Test the controllerfor the option list
        Test.startTest();
        List<SelectOption> testOptions = new List<SelectOption>();
        BatchLeadsController BatchLeadsControllerInstance = new BatchLeadsController();
        testOptions = BatchLeadsControllerInstance.getConfigurableFields();
        Test.stopTest();
        
        // Check all the options are retrived from the list 
        System.assertEquals(4, testOptions.size());
    }
}