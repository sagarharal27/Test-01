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
public class BestPracticeDataFactory {
    static Integer i;
    
    // Creating Account data for testing
    public static testMethod List<Account> accountData() {
        List<Account> accountDataList = new List<Account>();
        
        // Creating 200 records of Account Data
        for (i = 0; i < 200 ; i++) { 
            Account accountInstance = new Account(Name='Test', Email_Address__c='abc@test.com');
            accountDataList.add(accountInstance);
        }
        return accountDataList;
    }
    
    // Creating Contact data for test
    public static testMethod List<Contact> contactData() {
        List<Contact> contactDataList = new List<Contact>();
        
       // Creating 200 records of Contact Data
        for (i=0; i<200 ; i++) { 
            Contact contactInstance = new Contact(LastName='Test');
            contactDataList.add(contactInstance);
        }
        return contactDataList;
    }
}