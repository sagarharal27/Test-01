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
private class BatchLeadTest {
    static List<Lead> leadList = new List<Lead>(); 
    static List<Lead> duplicateLeadList = new List<Lead>(); 
    static Lead leadRecord;
    static Integer i = 0;
    
    /**
     * Create bulk data for lead  
     */
    static List<Lead> createLeadData() {
        
        // Creation of 200 lead records
        for (Integer j = 0; j < 200; j++) {
            leadRecord = new Lead(
                LastName = 'TestLead', 
                Company = 'testCompanyLead',
                Status = 'Open - Not Contacted'
            );
         leadList.add(leadRecord);
        }
        return leadList;
    }
    
    /**
     * Check the lead duplication of lead records with same name 
     */
    static testMethod void testDuplicateNameRecordsOfLead() {
        List<Lead> leadInstance = createLeadData();
        List<Lead> leadData = new List<Lead>();
        for (Lead leadObject : leadInstance) {
            leadObject.Email = 'abc@test.com';
            leadData.add(leadObject);
        }
        insert leadData;
        
        // Verify if all lead data is inserted successfully
        System.assertEquals(200, leadData.size());
        for (Lead leadIterator : leadData) {
            System.assert(leadIterator.Id != null);
        }
        
        // Insert the custom settings
        List<DuplicateLeads__c> criteriaList = new List<DuplicateLeads__c>();
        DuplicateLeads__c criteriaInstance = new DuplicateLeads__c(Name = 'Name');
        criteriaList.add(criteriaInstance);
        insert criteriaList;
        
        // Create an Instance and execute the batch
        Test.startTest();
        String deleteCriteria = 'Name';
        BatchLeads leadBatch = new BatchLeads();
        Database.executeBatch(leadBatch);
        Test.stopTest();
        
        // Retrive the lead records
        List<Lead> leadListResults = [
            SELECT 
                Id, 
                LastName, 
                Email
            FROM 
                Lead
        ];
        
        // Check if there is 1 record  in the leadListResult list
        System.assertEquals(1, leadListResults.size());
    }
    
    /**
     * Check the lead duplication of lead records with same email 
     */
    static testMethod void testDuplicateEmailRecordsOfLead() {
        List<Lead> leadInstance = createLeadData();
        List<Lead> leadData = new List<Lead>();
        for (Lead leadObject : leadInstance) {
            leadObject.Email = 'abc@test.com';
            leadData.add(leadObject);
        }
        insert leadData;
        
        // Verify if all lead data is inserted successfully
        System.assertEquals(200, leadData.size());
        for (Lead leadIterator : leadData) {
            System.assert(leadIterator.Id != null);
        }
        
        // Insert the custom settings
        List<DuplicateLeads__c> criteriaList = new List<DuplicateLeads__c>();
        DuplicateLeads__c criteriaInstance = new DuplicateLeads__c(Name = 'Email');
        criteriaList.add(criteriaInstance);
        insert criteriaList;
        
        // Create an Instance and execute the batch
        Test.startTest();
        String deleteCriteria = 'Email';
        BatchLeads leadBatch = new BatchLeads();
        Database.executeBatch(leadBatch);
        Test.stopTest();
        
        // Retrive the lead records
        List<Lead> leadListResults = [
            SELECT 
                Id, 
                LastName, 
                Email
            FROM 
                Lead
        ];
        
        // Check if there is 1 record  in the leadListResult list
        System.assertEquals(1, leadListResults.size());
    }
    
    /**
     * Check the lead duplication of lead records with same phone
     */
    static testMethod void testDuplicatePhoneRecordsOfLead() {
        
        List<Lead> leadInstance = createLeadData();
        List<Lead> leadData = new List<Lead>();
        for (Lead leadObject : leadInstance) {
            leadObject.Phone = '1234567890';
            leadData.add(leadObject);
        }
        insert leadData;
        
        // Verify if all lead data is inserted successfully
        System.assertEquals(200, leadData.size());
        for (Lead leadIterator : leadData) {
            System.assert(leadIterator.Id != null);
        }
        
        // Insert the custom settings
        List<DuplicateLeads__c> criteriaList = new List<DuplicateLeads__c>();
        DuplicateLeads__c criteriaInstance = new DuplicateLeads__c(Name = 'Phone');
        criteriaList.add(criteriaInstance);
        insert criteriaList;
        
        // Create an Instance and execute the batch
        Test.startTest();
        BatchLeads leadBatch = new BatchLeads();
        Database.executeBatch(leadBatch);
        Test.stopTest();
        
        // Retrive the lead records
        List<Lead> leadListResults = [
            SELECT 
                Id, 
                LastName, 
                Email
            FROM 
                Lead
        ];
        
        // Check if there is 1 record  in the leadListResult list
        System.assertEquals(1, leadListResults.size());
    }
    
    /**
     * Check the lead duplication with Name records 
     */ 
    static testMethod void testDifferentNameRecordsOfLead() {
        List<Lead> leadInstance = createLeadData();
        List<Lead> leadData = new List<Lead>();
        for (Lead leadObject : leadInstance) {
            i++;
            leadObject.LastName = 'TestLead' + i;
            leadData.add(leadObject);
        }
        
        // Insertion of lead data
        insert leadInstance;
        
        // Verify if all lead data is inserted successfully
        System.assertEquals(200, leadInstance.size());
        for (Lead leadIterator : leadInstance) {
            System.assert(leadIterator.Id != null);
        }
        
        // Insert the custom settings
        List<DuplicateLeads__c> criteriaList = new List<DuplicateLeads__c>();
        DuplicateLeads__c criteriaInstance = new DuplicateLeads__c(Name = 'Name');
        criteriaList.add(criteriaInstance);
        insert criteriaList;
        
        // Create an Instance and execute the batch
        Test.startTest();
        BatchLeads leadBatch = new BatchLeads();
        Database.executeBatch(leadBatch);
        Test.stopTest();
        
        // Retrive the lead records
        List<Lead> leadListResult = [
            SELECT 
                Id, 
                LastName, 
                Email
            FROM 
                Lead
        ];
        
        // Check if there are 200 records in the leadListResult list
        System.assertEquals(leadInstance.size(), leadListResult.size());
    }
    
    /**
     * Check the lead duplication with different email 
     */ 
    static testMethod void testDifferentEmailRecordsOfLead() {
        List<Lead> leadInstance = createLeadData();
        List<Lead> leadData = new List<Lead>();
        for (Lead leadObject : leadInstance) {
            i++;
            leadObject.Email = 'abc' + i + '@test.com' ;
            leadData.add(leadObject);
        }
        
        // Insertion of lead data
        insert leadInstance;
        
        // Verify if all lead data is inserted successfully
        System.assertEquals(200, leadInstance.size());
        for (Lead leadIterator : leadInstance) {
            System.assert(leadIterator.Id != null);
        }
        
        // Insert the custom settings
        List<DuplicateLeads__c> criteriaList = new List<DuplicateLeads__c>();
        DuplicateLeads__c criteriaInstance = new DuplicateLeads__c(Name = 'Email');
        criteriaList.add(criteriaInstance);
        insert criteriaList;
        
        // Create an Instance and execute the batch
        Test.startTest();
        BatchLeads leadBatch = new BatchLeads();
        Database.executeBatch(leadBatch);
        Test.stopTest();
        
        // Retrive the lead records
        List<Lead> leadListResult = [
            SELECT 
                Id, 
                LastName, 
                Email
            FROM 
                Lead
        ];
        
        // Check if there are 200 records in the leadListResult list
        System.assertEquals(leadInstance.size(), leadListResult.size());
    }
    
    /**
     * Check the lead duplication with different phone number records 
     */ 
    static testMethod void testDifferentPhoneRecordsOfLead() {
        List<Lead> leadInstance = createLeadData();
        List<Lead> leadData = new List<Lead>();
        for (Lead leadObject : leadInstance) {
            i++;
            leadObject.Phone = '98745632' + i;
            leadData.add(leadObject);
        }
        
        // Insertion of lead data
        insert leadInstance;
        
        // Verify if all lead data is inserted successfully
        System.assertEquals(200, leadInstance.size());
        for (Lead leadIterator : leadInstance) {
            System.assert(leadIterator.Id != null);
        }
        
        // Insert the custom settings
        List<DuplicateLeads__c> criteriaList = new List<DuplicateLeads__c>();
        DuplicateLeads__c criteriaInstance = new DuplicateLeads__c(Name = 'Phone');
        criteriaList.add(criteriaInstance);
        insert criteriaList;
        
        // Create an Instance and execute the batch
        Test.startTest();
        BatchLeads leadBatch = new BatchLeads();
        Database.executeBatch(leadBatch);
        Test.stopTest();
        
        // Retrive the lead records
        List<Lead> leadListResult = [
            SELECT 
                Id, 
                LastName, 
                Email
            FROM 
                Lead
        ];
        
        // Check if there are 200 records in the leadListResult list
        System.assertEquals(leadInstance.size(), leadListResult.size());
    }
}