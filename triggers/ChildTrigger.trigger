/**
 * 
 */

trigger ChildTrigger on Child__c ( before insert, after insert,
                                   before update, after update,
                                   before delete, after delete,
                                   after undelete
) {

    if (Trigger.isBefore) {

        if (Trigger.isInsert) {
            
        }

        if (Trigger.isUpdate) {
            
        }

        if (Trigger.isDelete) {
            
        }

        if (Trigger.isUndelete) {
            
        }

    }

    if (Trigger.isAfter) {

        if (Trigger.isInsert) {
            ChildTriggerHandler.onAfterInsert(trigger.newMap); 
        }

        if (Trigger.isUpdate) {
            ChildTriggerHandler.onAfterUpdate(trigger.oldMap, trigger.newMap);
        }

        if (Trigger.isDelete) {
            ChildTriggerHandler.onAfterDelete(trigger.oldMap); 
        }

        if (Trigger.isUndelete) {
            ChildTriggerHandler.onAfterUndelete(trigger.newMap); 
        }

    }

}