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
private class RestLeadManipulationTest {
    
    /**
     * Test the insert lead functionality
     */
    static testMethod void testLeadInsert() {
        Test.startTest();
        RestLeadManipulation.createLead(
            'Test', 
            'rest', 
            'Open - Not Contacted', 
            'soap.inc', 
            'soap@test.com', 
            '8888319158'
        );
        Test.stopTest();
        List<Lead> leadList = [
            SELECT
                Id
            FROM
                Lead
            WHERE
                FirstName = 'Test'
            AND
                LastName = 'rest'
        ];
        
        // Verify if the lead is inserted
        System.assertEquals(1, leadList.size());
    }
    
    /**
     * Test the delete lead functionality
     */
    static testMethod void testLeadDelete() {
        RestContext.Request = new RestRequest();
        RestContext.Request.params.put('FirstName', 'Test');
        RestContext.Request.params.put('LastName', 'rest');
        RestContext.Request.params.put('Email', 'rest@test.com');
        RestContext.Request.params.put('Phone', '8888319158'); 
        
        Test.startTest();
        RestLeadManipulation.deleteLead();
        Test.stopTest();
        
        List<Lead> leadList = [
            SELECT 
                Id
            FROM
                Lead
            WHERE
                FirstName = 'Test'
            AND
                LastName = 'rest'
            AND
                Email = 'rest@test.com'
            AND
                Phone = '8888319158'
        ];
        
        // Verify if the lead record is deleted
        System.assert(leadList.isEmpty());
    
    }
    
    
    /**
     * Test the update lead functionality
     */
    static testMethod void testLeadUpdate() {
        
        Lead leadRecord = new Lead(
            FirstName = 'Test', 
            LastName = 'rest', 
            Status = 'Open - Not Contacted', 
            Company = 'soap.inc', 
            Email = 'rest@test.com', 
            Phone = '8888319158'
        );
        insert leadRecord;
        
        System.assert(leadRecord.Id != null);
        
        Test.startTest();
        RestLeadManipulation.leadUpdate(
            'Test', 
            'rest', 
            'updateRest@test.com', 
            '7896541230'
        ); 
        Test.stopTest(); 
        List<Lead> leadList = [
            SELECT
                Id,
                Phone,
                Email
            FROM
                Lead
            WHERE
                FirstName = 'Test'
            AND
                LastName = 'rest'
        ];
        
        // Verify if the lead record is updated
        for (Lead leadObject : leadList) {
            System.assert(leadObject.Phone != leadRecord.Phone);
            System.assert(leadObject.Email != leadRecord.Email);
        }
    }
    
    /**
     * Test the insert lead functionality
     */
    static testMethod void testLeadInsertFailed() {
        Test.startTest();
        RestLeadManipulation.createLead(
            'Test', 
            'rest', 
            'Open - Not Contacted', 
            'soap.inc', 
            'soaptest.com', 
            '8888319158'
        );
        Test.stopTest();
        List<Lead> leadList = [
            SELECT
                Id
            FROM
                Lead
            WHERE
                FirstName = 'Test'
            AND
                LastName = 'rest'
        ];
        
        // Verify if the lead is inserted
        System.assertEquals(0, leadList.size());
    }
    
    
    /**
     * Test the update lead functionality
     */
    static testMethod void testLeadUpdateFailed() {
        
        Lead leadRecord = new Lead(
            FirstName = 'Test', 
            LastName = 'rest', 
            Status = 'Open - Not Contacted', 
            Company = 'soap.inc', 
            Email = 'rest@test.com', 
            Phone = '8888319158'
        );
        insert leadRecord;
        System.assert(leadRecord.Id != null);
        
        Test.startTest();
        RestLeadManipulation.leadUpdate(
            'Test', 
            'rest', 
            'updateRest@testcom', 
            '7896541230abc'
        ); 
        Test.stopTest(); 
        List<Lead> leadList = [
            SELECT
                Id,
                Email,
                Phone
            FROM
                Lead
            WHERE
                FirstName = 'Test'
            AND
                LastName = 'rest'
        ];
         
        // Verify if the lead record is updated
        for (Lead leadObject : leadList) {
            System.assert(leadObject.Phone == leadRecord.Phone);
            System.assert(leadObject.Email == leadRecord.Email);
        }
    }
    
    
    /**
     * Test the delete lead functionality
     */
    static testMethod void testLeadDeleteFailed() {
        Lead leadRecord = new Lead(
            FirstName = 'Test', 
            LastName = 'rest', 
            Status = 'Open - Not Contacted', 
            Company = 'soap.inc', 
            Email = 'rest@test.com', 
            Phone = '8888319158'
        );
        insert leadRecord;
        System.assert(leadRecord.Id != null);
        
        RestContext.Request = new RestRequest();
        RestContext.Request.params.put('FirstName', 'Test');
        RestContext.Request.params.put('LastName', 'rest');
        RestContext.Request.params.put('Email', 'rest@test.com');
        RestContext.Request.params.put('Phone', '888319158'); 
        
        Test.startTest();
        RestLeadManipulation.deleteLead();
        Test.stopTest();
        
        List<Lead> leadList = [
            SELECT 
                Id
            FROM
                Lead
            WHERE
                FirstName = 'Test'
            AND
                LastName = 'rest'
            AND
                Email = 'rest@test.com'
            AND
                Phone = '8888319158'
        ];
        
        // Verify if the lead record is deleted
        System.assertEquals(1, leadList.size());
    }
}