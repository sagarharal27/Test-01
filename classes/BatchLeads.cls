/**
 * Removal of duplicate Leads 
 * During the Campaigning, It might happen that representative creates duplicate leads in an org. 
 * So admin want to build a process which will run every 3 hours/day &  
 * remove the duplicate leads from the org. 
 * The criteria to find the duplicate records should be configurable. 
 */
global with sharing class BatchLeads implements Database.Batchable<sObject>, Database.Stateful {
    public Map<String, Lead> uniqueLeadMap;
    public List<Lead> duplicateLeadsList;
    public String deleteCriteria;
    Map<String, DuplicateLeads__c> leadDeletionCriteria;
    
    /** 
     * Initialization of uniqueLeadMap and duplicateLeadsList in constructor
     */
    public BatchLeads() {
        
        // Get values from custom settings
        leadDeletionCriteria = DuplicateLeads__c.getAll();
        for (String stringInstance : leadDeletionCriteria.keySet()) {
            deleteCriteria = stringInstance;
        }
        
        // Map to store unique leads on basis of email id; 
        // Email in key part, Lead record in value part
        uniqueLeadMap = new Map<String, Lead>();
        
        // List to store Duplicated leads
        duplicateLeadsList = new List<Lead>(); 
    }
     
    /**
     * Query to fetch the Leads and get all lead which have email not null  
     */
    global Database.QueryLocator start(Database.BatchableContext BatchableContextInstance) {
        return Database.getQueryLocator([
            SELECT 
                Id, 
                Name, 
                Email,
                Phone
            FROM 
                Lead
        ]);
    }
     
    /**
     * Sort the lead and add unique leads in map uniqueLeadMap and 
     * the duplicate leads in the list duplicateLeadsList 
     */
    global void execute(Database.BatchableContext BatchableContextInstance, List<Lead> leadList) {
        List<Lead> leadListIterate = leadList;
        
        // Configure the duplicate leads on Name
        if (deleteCriteria == 'Name') {
            for (Lead leadObject : leadListIterate) {
                
                // Add to unique map name as key
                if (!uniqueLeadMap.containsKey(leadObject.Name)) { 
                    uniqueLeadMap.put(leadObject.Name, leadObject);
                }
                
                // Add to duplicate list
                else {
                    duplicateLeadsList.add(leadObject);
                }
            }
            
        // Configure the duplicate leads on Email Address
        } 
        if (deleteCriteria == 'Email') {
            for (Lead leadObject : leadListIterate) {
                
                // Add to unique map email as key
                if (!uniqueLeadMap.containsKey(leadObject.Email)) { 
                    uniqueLeadMap.put(leadObject.Email, leadObject);
                }
                
                // Add to duplicate list
                else {
                    duplicateLeadsList.add(leadObject);
                }
            }
            
        // Configure the duplicate leads on phone number
        }
        if (deleteCriteria == 'Phone') {
            for (Lead leadObject : leadListIterate) {
                
                // Add to unique map phone as key
                if (!uniqueLeadMap.containsKey(leadObject.Phone)) { 
                    uniqueLeadMap.put(leadObject.Phone, leadObject);
                }
                
                // Add to duplicate list
                else {
                    duplicateLeadsList.add(leadObject);
                }
            }
        }
         
        // Null check befor DML operation
        if (!duplicateLeadsList.isEmpty()) {
            delete duplicateLeadsList;
        }
    }
     
    /**
     * Print the final map with unique lead records with 
     * email address as key and lead record in value 
     */
    global void finish(Database.BatchableContext BatchableContextInstance) {
        System.debug(' Map of Unique Lead records : ' + uniqueLeadMap);
    }
}