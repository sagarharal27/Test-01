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
public class Test_BestPracticeTriggerHandler {
    static Integer i;
    
    /**
     * Creating data for account object
     */
    static List<Account> createAccountData() {
        
        // Creating 200 records of Account Data
        List<Account> accountDataList = new List<Account>();
        for (i = 0; i < 200; i++) { 
            Account accountInstance = new Account(Name='Test', Website='www.test.com', 
                Email_Address__c = 'abc@test.com');
            accountDataList.add(accountInstance);
        }
        return accountDataList;
    }
    
    /**
     * Creating data for contact object
     */
    static List<Contact> createContactData() {
        List<Contact> contactDataList = new List<Contact>();
        
        // Creating 200 records of Contact Data
        for (i = 0; i < 200; i++) { 
            Contact contactInstance = new Contact(LastName = 'Test', Email = 'xyz@test.com');
            contactDataList.add(contactInstance);
        }
        return contactDataList;
    }
     
    /** 
     * Check with valid data
     */
    static testMethod void validAccountContactDataCheck() {
        List<Account> accountDataList = createAccountData();
        insert accountDataList;
        
        // Verify if all account records inserted successfully
        System.assertEquals(200, accountDataList.size());
        for (Account accountInstance : accountDataList) {
            System.assert(accountInstance.Id != null);
        }
        
        List<Contact> contactDataList =  createContactData();
        
        // Checking the governor limits
        Test.startTest();
        insert contactDataList;
        Test.stopTest();
        
        // Get the list of contacts where AccountId is in the list of account data
        List<Contact> contactDataListAfterInsertion = [
            SELECT 
                AccountId
            FROM 
                Contact
            WHERE
                AccountID IN :accountDataList
            ]; 
            
        // Verify if we retrived 200 records as inserted
        System.assertEquals(200, contactDataListAfterInsertion.size());
    }
    
    /**
     * Check with  blank account data  
     */
    static testMethod void contactEmailDomainBlankCheck() {
        List<Account> accountListData = createAccountData();
        List<Contact> contactListData = createContactData();
        List<Account> accountList = new List<Account>();
        for (Account accountInstance : accountListData) {
            accountInstance.Website = 'www.gmail.com';
            accountList.add(accountInstance);
        }
        insert accountList;
        
        // Verify if all account records inserted successfully
        System.assertEquals(200, accountList.size());
        for (Account accountInstance : accountList) {
            System.assert(accountInstance.Id != null);
        }
        
        // Checking the governor limits
        Test.startTest();
        insert contactListData;
        Test.stopTest();
        
        // Getting the list of contacts 
        List<Contact> contactData = [
            SELECT 
                AccountId
            FROM 
                Contact
            ];
        
        // Verify if we are getting null in the contact lookup field for account
        for (i = 0; i < 200; i++) {
            System.assert(contactData[i].AccountId == null);
        }
    }

    /**
     * Check with  blank contact data
     */
    static testMethod void accountDomainBlankCheck() {
        List<Account> accountListData = createAccountData();
        List<Contact> contactListData = createContactData();
        insert accountListData;
        
        // Verify if all account records inserted successfully
        System.assertEquals(200, accountListData.size());
        for (Account accountInstance : accountListData) {
            System.assert(accountInstance.Id != null);
        }
        
        List<Contact> contactList = new List<Contact>();
        for (Contact contatcInstance : contactListData) {
            contatcInstance.Email = 'abc@gmail.com';
            contactList.add(contatcInstance);
        }
        
        // Checking the governor limits
        Test.startTest();
        insert contactListData;
        Test.stopTest();
        
        // Getting the list of contacts
        List<Contact> contactData = [
            SELECT 
                AccountId
            FROM 
                Contact
            ];
        
        // Verify if we are getting null in the contact lookup field for account
        for (i = 0; i < 200; i++) {
            System.assert(contactData[i].AccountId == null);
        }
    }
    
    /*
     * Check with blank account data and blank contact data
     */
    static testMethod void accountDomainContactEmailDomainBlankCheck() {
        List<Account> accountListData = createAccountData();
        List<Contact> contactListData = createContactData();
        insert accountListData;
        
        // Verify if all account records inserted successfully
        System.assertEquals(200, accountListData.size());
        for (Account accountInstance : accountListData) {
            System.assert(accountInstance.Id != null);
        }
        
        // Checking the governor limits
        Test.startTest();
        insert contactListData;
        Test.stopTest();
        
        // Getting the list of contacts
        List<Contact> contactData = [
            SELECT 
                AccountId
            FROM 
                Contact
            ]; 
        
        // Verify if we are getting null in the contact lookup field for account
        for (i = 0; i < 200; i++) {
            System.assert(contactData[i].AccountId == null);
        }
    }
}