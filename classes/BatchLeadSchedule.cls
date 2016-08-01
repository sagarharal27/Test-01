/**
 * Schedulable class for to delete the duplicate leads
 */
global with sharing class BatchLeadSchedule implements Schedulable {
    global void execute(SchedulableContext schedulableContext) {
        BatchLeads batchLeadInstance = new BatchLeads();
        Database.executeBatch(batchLeadInstance);
     }
}