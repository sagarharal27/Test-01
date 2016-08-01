/**
  *Write a Trigger on  Lead which will create the clone record.
  */

// Trigger on Lead object after insert 
trigger LeadCloneTrigger on Lead(after insert) {
    TriggerSetting__c disableTriggerInstance = TriggerSetting__c.getInstance();
    if(disableTriggerInstance.DisableTrigger__c == false) {
        if(Trigger.isAfter) {
            if(Trigger.isInsert) {
                // pass the inserted values to the handler class constructor
                LeadCloneHandler LeadHandlerInstance = new LeadCloneHandler(Trigger.new);
            }
        }
    }
}