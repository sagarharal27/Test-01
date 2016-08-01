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
private class SoapLeadManipulationTest {
    
    /**
     * Test the insert lead functionality
     */
    static testMethod void testLeadInsert() {
        Test.startTest();
        SoapLeadManipulation.createLead(
            'Test', 
            'Soap', 
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
                LastName = 'Soap'
        ];
        
        // Verify if the lead is inserted
        System.assert(!leadList.isEmpty());
    }
    
    /**
     * Test the delete lead functionality
     */
    static testMethod void testLeadDelete() {
        Lead leadInstance = new Lead(
            FirstName = 'Test',
            LastName = 'Soap',
            Status = 'Open - Not Contacted',
            Company = 'soap.corp',
            Email = 'test@soap.com',
            Phone = '7412589630'
        );
        insert leadInstance; 
        
        // Verify if lead records inserted successfully
        System.assert(leadInstance.Id != null);
        Test.startTest();
        SoapLeadManipulation.deleteLead(
            'Test', 
            'Soap', 
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
                LastName = 'Soap'
            AND
                Email = 'soap@test.com'
            AND
                Phone = '8888319158'
        ];
        
        // Verify if the lead record is deleted
        System.assert(leadList.isEmpty());
    }
   
    /**
     * Test the update functionality 
     */
    static testMethod void testLeadUpdate() {
        Lead leadInstance = new Lead(
            FirstName = 'Test',
            LastName = 'Soap',
            Status = 'Open - Not Contacted',
            Company = 'soap.corp',
            Email = 'test@soap.com',
            Phone = '7412589630'
        );
        insert leadInstance; 
        
        // Verify if lead records inserted successfully
        System.assert(leadInstance.Id != null);
        Test.startTest();
        SoapLeadManipulation.updateLead(
            'Test', 
            'Soap', 
            'soap@test.com', 
            '8888319158'
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
                LastName = 'Soap'
        ];
       
       // Verify if the email and phone number of lead are updated
        for (Lead leadRecord : leadList) {
            System.assertNotEquals(leadRecord.Email, leadInstance.Email);
            System.assertNotEquals(leadRecord.Phone, leadInstance.Phone);
       }
    }
    
    
     /**
     * Test the insert lead functionality
     */
    static testMethod void testLeadInsertFailed() {
        Test.startTest();
        SoapLeadManipulation.createLead(
            'Test', 
            '', 
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
                LastName = 'Soap'
        ];
        
        // Verify if the lead is inserted
        System.assert(leadList.isEmpty());
    }
    
    /**
     * Test the delete lead functionality
     */
    static testMethod void testLeadDeleteFailed() {
        Lead leadInstance = new Lead(
            FirstName = 'Test',
            LastName = 'Soap',
            Status = 'Open - Not Contacted',
            Company = 'soap.corp',
            Email = 'test@soap.com',
            Phone = '7412589630'
        );
        insert leadInstance; 
        
        // Verify if lead records inserted successfully
        System.assert(leadInstance.Id != null);
        Test.startTest();
        SoapLeadManipulation.deleteLead(
            'Soap', 
            'Test', 
            'soaptest.com', 
            '7412589630'
        );
        Test.stopTest();
        List<Lead> leadList = [
            SELECT
                Id
            FROM
                Lead
        ];
        
        // Verify if the lead record is deleted
        System.assert(!leadList.isEmpty());
    }
    
    /**
     * Test the update functionality 
     */
    static testMethod void testLeadUpdateFailed() {
        Lead leadInstance = new Lead(
            FirstName = 'Test',
            LastName = 'Soap',
            Status = 'Open - Not Contacted',
            Company = 'soap.corp',
            Email = 'test@soap.com',
            Phone = '7412589630'
        );
        insert leadInstance; 
        
        // Verify if lead records inserted successfully
        System.assert(leadInstance.Id != null);
        Test.startTest();
        SoapLeadManipulation.updateLead(
            'Test', 
            'Soap', 
            'testsoap.com', 
            '7412589630'
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
                LastName = 'Soap'
        ];
       
       // Verify if the email and phone number of lead are updated
        for (Lead leadRecord : leadList) {
            System.assertEquals(leadRecord.Email, leadInstance.Email);
            System.assertEquals(leadRecord.Phone, leadInstance.Phone);
       }
    }
}