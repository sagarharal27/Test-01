/**
 * Trigger on the contact query junction (after insert)
 */
trigger ContactQueryTrigger on Contact_Query_Junction__c (after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            QueryHandler handlerInstance = new QueryHandler(Trigger.new);
        }
    } 
}