/**
 * Collection of Closed Won Opportunities 
 * The Primary contact associated with an account needs to know which all are the 
 * closed won opportunities for his account per day. 
 * Create a process which will run everyday in the midnight & collect all the 
 * Closed won opportunities of that account in a day & send an email to Primary Contact. 
 * The email body should contain the Opportunity Name & it's respective amount 
 * with the aggregated amount in the end. 
 */
global with sharing class BatchApex implements Database.Batchable<SObject>, Database.Stateful, 
    Schedulable {
    Map<Account, WrapperClass> accountOpportunityMap;
    public static Double totalOpportunityAmount;
    
    /**
     * Constructor to initialize the map to store opportunities and their sum
     */
    public BatchApex() {
        accountOpportunityMap = new Map<Account, WrapperClass>();
    }
    
    /**
     * Get all opportunities whos lookup field to account is not blank 
     * and email field on Account object is not blank
     */
    global Database.QueryLocator start(Database.BatchableContext batchableContext) {
            return Database.getQueryLocator([
                SELECT 
                    Id, 
                    Name, 
                    Amount, 
                    StageName, 
                    Opportunity.Account.Primary_Email__c, 
                    AccountId 
                FROM 
                    Opportunity 
                WHERE 
                    AccountId <> null 
                AND 
                    Opportunity.Account.Primary_Email__c <> null
                AND
                    StageName = 'Closed Won'
                AND
                    CloseDate = TODAY
            ]);
    }
    
    /**
     * This will sum up all the closed won opportunities of a perticular account per day
     * and will send a mail to the primary contact
     */
    global void execute(
        Database.BatchableContext batchableContext,
        List<Opportunity> opportunityList) {
        for (Opportunity opportunityInstance : opportunityList) {
            
            if (accountOpportunityMap.containsKey(opportunityInstance.Account)) {
                
                WrapperClass wrapperInstance = 
                    accountOpportunityMap.get(opportunityInstance.Account);
                
                // Add the opportunity in the opportunity list in the wrapper class
                wrapperInstance.opportunityList.add(opportunityInstance);
                
                // Add the amount of that opportunity which is inserted in the opportunity list 
                // in the sum variable in the wrapper class
                wrapperInstance.amountSum += opportunityInstance.Amount;
                totalOpportunityAmount += opportunityInstance.Amount;
                accountOpportunityMap.put(
                    opportunityInstance.Account,
                    wrapperInstance
                );
            } else {
                wrapperClass wrapperInstance = new wrapperClass();
                wrapperInstance.opportunityList.add(opportunityInstance);
                wrapperInstance.amountSum = opportunityInstance.Amount;
                totalOpportunityAmount = opportunityInstance.Amount;
                accountOpportunityMap.put
                    (opportunityInstance.Account, 
                    wrapperInstance
                );
            }
        }
    }
    
    /**
     * This is an execute block of schedulable.
     */
    global void execute(SchedulableContext schedulableContext) {
        
    }
    
    /**
     * The finish block to send mail to primary contact of all opportunities 
     * with the sum of their amount.
     */
    global void finish(Database.BatchableContext batchableContext) {
        List<Messaging.SingleEmailMessage> mailInstance = new List<Messaging.SingleEmailMessage>();
        List<String> sendToList = new List<String>();
        for (Account emailInstance : accountOpportunityMap.keySet()) {
            
            Messaging.SingleEmailMessage individualMail = new Messaging.SingleEmailMessage();
            
            WrapperClass wrapperInstance = accountOpportunityMap.get(emailInstance);
            
            // Recipient email id
            sendToList.add(emailInstance.Primary_Email__c);
            individualMail.setToAddresses(sendToList);
            individualMail.setSenderDisplayName('SalesForce.com');
            individualMail.setSubject('List Of Opportunities and Amount\n  \n\n ');
            String body = 'Hello ' + IndividualMail;
            body += ' Opportunities associated to your \n\n\n'; 
            body += ' account and the aggregate of their amount \n\n\n';
            body += ' ' + wrapperInstance.opportunityList + ' ' + wrapperInstance.amountSum;
            for (Opportunity opportunityInstance : wrapperInstance.opportunityList) {
                body += '\n\n' + opportunityInstance.Name + ' ' + opportunityInstance.Amount;
            }
            body += '\n ' +wrapperInstance.amountSum;
            individualMail.setHtmlBody(body);
            mailInstance.add(individualMail); 
        }
        Messaging.sendEmail(mailInstance);
    }
    
     /**
     * Wrapper class with opportunity and sum
     */
    public class WrapperClass {
         List<Opportunity> opportunityList;
         Double amountSum;
         
        /**
         *Constructor to initialize the warpper class variables
         */
        public WrapperClass() {
            opportunityList = new List<Opportunity>();
            amountSum = 0;
        }
    }
}