/***************************************************************************************************
 Class Name: AvoidDuplicationOfLead
 Created Date:10/8/2015
 Description: This class sends mail to Account with Amount of opportunity and aggregate 
***************************************************************************************************/
global with sharing class AvoidDuplicationOfLead implements Database.Batchable<sObject>{
<<<<<<< HEAD
    
    //Map of email and lead 
    public Map<String,Lead> mapEmailLead;
    //Creating list of duplicate leads
=======
     
    public Map<String,Lead> mapEmailLead;
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
    public List<Lead> lstduplicateLeads;
    //Creating constructor with map and lead
    public AvoidDuplicationOfLead() {
         mapEmailLead = new  Map<String,Lead>();
         lstduplicateLeads = new List<Lead>(); 
    }
    
    //start method
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id,
                                                Name,
                                                Email
                                         FROM Lead
                                         WHERE Email <> NULL ]);
    }
<<<<<<< HEAD
    global void execute(Database.BatchableContext bc, List<Lead> lstLead) {
        System.debug('lstLead:::::'+lstLead);
        
        //for each lead in list of lead
        for (Lead leadInstance : lstLead) {
            
            //if map is not having mail
            if (!mapEmailLead.containskey(leadInstance.Email)) {
                //put it into map
                mapEmailLead.put(leadInstance.Email, leadInstance);
                System.debug('Map:::'+mapEmailLead);
=======
    
    global void execute(Database.BatchableContext bc, List<Lead> lstLead) {
        System.debug('lstLead:::::'+lstLead);
        //for each lead in list of lead
        for (Lead leadInstance : lstLead) {
            //if map is not having mail
            if (!mapEmailLead.containskey(leadInstance.Email)) {
                //put it into map
                mapEmailLead.put(leadInstance.Email,leadInstance);
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
            } 
          else {
              //add that email in the list
              lstduplicateLeads.add(leadInstance);
          }
<<<<<<< HEAD
           System.debug('**********:'+lstduplicateLeads);
        }
       
=======
        }
        System.debug('mapEmail_lead::::'+mapEmailLead);
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
        if(!lstduplicateLeads.isEmpty()) 
            //if list is not empty then delete the list
            delete lstduplicateLeads;
        else 
            system.debug('No records......');
<<<<<<< HEAD
    
    }
    global void finish(Database.BatchableContext bc) {
=======
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug('Finish called!!!');
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
        System.debug('Map of Unique Leads :'+mapEmailLead);
    }
}