/**
 * Handler Class to perform functionallity on trigger of Child__c object 
 */
public with sharing class ChildTriggerHandler {

    /**
     * Constructor.
     */
    public ChildTriggerHandler() {

    }

    /**************************************  BEFORE EVENTS  ***************************************/

    /**
     * Method to perform functionallity Before Child__c records are Inserted.
     */
    public static void onBeforeInsert() {
        
    }

    /**
     * Method to perform functionallity Before Child__c records are Updated.
     */
    public void onBeforeUpdate() {
        
    }

    /**
     * Method to perform functionallity Before Child__c records are Deleted.
     */
    public void onBeforeDelete() {
        
    }

    /**************************************  AFTER EVENTS  ****************************************/

    /**
     * Method to perform functionallity After Child__c records are Inserted.
     */
    public static void onAfterInsert(Map<Id, Child__c> idChildMap) {
        RollupChildRecords r = new RollupChildRecords();
        r.RollupChildAmount(idChildMap);
    }

    /**
     * Method to perform functionallity After Child__c records are Updated.
     */
    public static void onAfterUpdate(
        Map<Id, Child__c> idChildMapOld, 
        Map<Id, Child__c> idChildMapNew
    ) {
        Map<Id, Child__c> idChildMap = 
            ChildTriggerHandler.verifyFieldUpdate(idChildMapOld, idChildMapNew);
        if (idChildMap != null && !idChildMap.isEmpty()) {
            RollupChildRecords r = new RollupChildRecords();
            r.RollupChildAmount(idChildMap);
        }
    }

    /**
     * Method to perform functionallity After Child__c records are Deleted.
     */
    public static void onAfterDelete(Map<Id, Child__c> idChildMap) {
        RollupChildRecords r = new RollupChildRecords();
        r.RollupChildAmount(idChildMap);
    }

    /**
     * Method to perform functionallity After Child__c records are Undeleted.
     */
    public static void onAfterUndelete(Map<Id, Child__c> idChildMap) {
        RollupChildRecords r = new RollupChildRecords();
        r.RollupChildAmount(idChildMap);
    }

    /**************************************  FILTER METHODS  **************************************/

    /**
     * Method to filter the Child__c records on bassis of updation of Amount__c field.
     */
    public static Map<Id, Child__c> verifyFieldUpdate(
        Map<Id, Child__c> idChildMapOld, 
        Map<Id, Child__c> idChildMapNew
    ) {
        Map<Id, Child__c> idChildMap = new Map<Id, Child__c>();
        for (Id id : idChildMapNew.keySet()) {
            if(idChildMapOld.containsKey(id)) {
                if(idChildMapOld.get(id).Amount__c != idChildMapNew.get(id).Amount__c) {
                    idChildMap.put(id, idChildMapNew.get(id));
                }
            }
        }
        return idChildMap;
    }

}