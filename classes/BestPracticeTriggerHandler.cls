/**
 * ABC Containers require the ability to automatically associate a Contact created 
 * in their Salesforce Instance with the respective Account based on the email domain specified 
 * in the primary email address of the Contact. 
 * The association should happen real time as soon as a Contact record is created within the system.
 */

public with sharing class BestPracticeTriggerHandler {
    public BestPracticeTriggerHandler(List<Contact> triggerContact) {
        
        // Initialization of map
        Map<String,Id> accountMap = new Map<String,Id>();
        Map<String,Id> contactEmailMap = new Map<String,Id>();
        
        // Get list of Account whos website field is not null 
        List<Account> accountDomainList = [
            SELECT
                Website
            FROM
                Account
            WHERE
                Website <> null
            ]; // Query
        
        // Iterate over Account object and extract the domain name from the website field
        for (Account accountInstance : accountDomainList) {
            String domainAccount = ((accountInstance.Website).substringAfterLast('w.'));
            accountMap.put(domainAccount, accountInstance.Id);
        } // For
        
        // Iterate over Contacts object and check if website domain exist in contact email field
        for (Contact contactInstance : triggerContact) {
            if (contactInstance.Email != NULL) {
                String contactDomainName = ((contactInstance.Email).substringAfterLast('@'));
                contactInstance.AccountId = accountMap.get(contactDomainName);
            } //If
        } //For
    } // Constructor
} // Main