/**
 * Class to update the Parent records on updation of Amount filed on Child records. 
 */
public with sharing class RollupChildRecords {

    /**
     * Constructor
     */
    public RollupChildRecords() {
        
    }

    /**
     * Method to update the Parent records
     */
    public void RollupChildAmount(Map<Id, Child__c> idChildMap) {

        List<Parent__c> parentUpdateList = new List<Parent__c>();
        Set<Id> parentIdSet = new Set<Id>();

        for (Id childId : idChildMap.keySet()) {
            if (idChildMap.get(childId).ParentId__c != null) {
                parentIdSet.add(idChildMap.get(childId).ParentId__c);
            }
        }
        //System.debug('parentIdSet  >>>  ' + parentIdSet);

        List<AggregateResult> arrList = [ SELECT Sum(Amount__c)
                                               , COUNT(Id)
                                               , lobo__ParentId__c 
                                            FROM Child__c 
                                           WHERE lobo__ParentId__c 
                                              IN :parentIdSet 
                                        GROUP BY lobo__ParentId__c
        ]; 
        //System.debug( 'arrList  >>>  ' + arrList);

        for (AggregateResult ar : arrList) {
            Parent__c parentObj = new Parent__c(
                Id = (Id) ar.get('lobo__ParentId__c'), 
                Total_Amount__c = (Decimal) ar.get('expr0'),
                Total_Childs__c = (Decimal) ar.get('expr1')
            );
            parentUpdateList.add(parentObj);
        }

        try {
            update parentUpdateList;
        } catch (Exception e) {
            System.debug('Exception  >>>  ' + e);
        }

    }

}