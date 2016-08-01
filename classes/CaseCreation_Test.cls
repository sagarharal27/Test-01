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
private class CaseCreation_Test {
    static testMethod void test_CaseCreation() {
        // Insert data in account object
        List<Account> accountInstance = new List<Account>();
        // Creating bulk data for test
        for (Integer i=0;i<200;i++) {
            Account accountList = new Account(Name='TestDemo' + i, Person_Email__c='abc@gmail.com', 
                                                Email_Address__c='abc@gmail.com');
            accountInstance.add(accountList);
        }
        // Insert data in case object
        List<Case> caseInstance = new List<Case>();
        // Creating bulk data for test
        for (Integer i = 0; i < 200; i++) {
            Case caseList = new Case(Status='New', Origin='Email');
            caseInstance.add(caseList);
        }
        
        // Run test        
        Test.StartTest();
        insert accountInstance;
        insert caseInstance;
        Test.StopTest();
        
        List<Case> caseList=[SELECT c.Account.Id, c.AccountId FROM Case c];
        for (Case caseAccountInstance : caseList) {
            system.assertEquals(caseAccountInstance.Account.Id,caseAccountInstance.Id);
        }
     }
}