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
private class BatchApexTest {
    
    /**
     * Test the opportunity mail
     */
    static testMethod void testOpportunityAmount() {
        Double testAmount = 0;
        List<Account> accountList = new List<Account>();
        List<Opportunity> opportunityList = new List<Opportunity>();
        accountList.add(
                new Account(
                Name = 'test',
                Primary_Email__c = 'craig@eternussolutions.com',
                Email_Address__c = 'test@eternussolutions.com')
        );
        
        // Insert the account data
        insert accountList;
        
        // Verify if all account data is inserted successfully
        System.assertEquals(1, accountList.size());
        for (Account accountInstance : accountList) {
            System.assert(accountInstance.Id != null);
        }
        
        // Create Opportunity data
        for (Integer i = 0; i < 5; i++) {
            opportunityList.add(
                new Opportunity(
                Amount = 10, 
                StageName = 'Closed Won',
                Name = 'Closed Opportunity' + i, 
                CloseDate = (Date) Date.today(), 
                AccountId = accountList[0].Id) 
            ); 
        } 
        
        // Insert the opportunity data
        insert opportunityList; 
        
        // Verify if all opportunity data is inserted successfully
        System.assertEquals(5, opportunityList.size());
        for (Opportunity opportunityInstance : opportunityList) {
            testAmount += opportunityInstance.Amount;
            System.assert(opportunityInstance.Id != null);
        }
        
        // Create an instance of the batch and execute the batch
        Test.startTest();
        BatchApex batchInstance = new BatchApex();
        Database.executeBatch(batchInstance);
        Test.stopTest();
        
        // Check the final amount of the opportunities  
        System.assertEquals(testAmount, BatchApex.totalOpportunityAmount);
    }
}