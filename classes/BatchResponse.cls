/**
 * Batch Class to send the responses to the queries
 */
global with sharing class BatchResponse implements Database.Batchable<sObject>, Database.Stateful {
    
    /**
     * Get the list of queries to be responded
     */
    global Database.QueryLocator start(Database.BatchableContext BatchableContextInstance) {
        return Database.getQueryLocator([
                SELECT 
                     Id,
                     ContactId__c,
                     QueryId__c,
                     Status__c
                FROM 
                    Contact_Query_Junction__c 
                WHERE 
                   Status__c = 'Open'
                AND 
                    CreatedDate = Today
        ]);
    } 
    
    /**
     * Excute Block
     */
    global void execute(
        Database.BatchableContext BatchableContextInstance, 
        List<Contact_Query_Junction__c> junctionList) {
        
        // Get the template id
        EmailTemplate templateInstance = new EmailTemplate();
        templateInstance = [
            SELECT 
                Id 
            FROM 
                EmailTemplate 
            WHERE 
                Name = 'GoogleForce Results'
        ];
        
        List<Contact_Query_Junction__c> updatedList = new List<Contact_Query_Junction__c>();
        
        List<Messaging.SingleEmailMessage> emailInstanceList 
            = new List<Messaging.SingleEmailMessage>();
        for (Contact_Query_Junction__c instance : junctionList) {
            Messaging.SingleEmailMessage emailInstance = new Messaging.SingleEmailMessage();
            
            // Send to
            emailInstance.setTargetObjectId(instance.ContactId__c);
            
            // template id
            emailInstance.setTemplateId(templateInstance.Id);
            
            // Query id
            emailInstance.setWhatId(instance.QueryId__c);
            emailInstance.setSaveAsActivity(false);
            
            // Update the status field on the junction object to closed 
            instance.Status__c = 'Closed';
            
            // Add all the emails to a list
            emailInstanceList.add(emailInstance);
        }
        try {
            Messaging.sendEmail(emailInstanceList);
            update junctionList;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    } 
    
    /**
     * The Fininsh Block
     */
    global void finish(Database.BatchableContext BatchableContextInstance) {
        
    }
    
}