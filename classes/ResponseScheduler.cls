/**
 * Schedulable class to excute the batch to send the responses
 */
global with sharing class ResponseScheduler implements Schedulable { 
    
    /**
     * Excute the batch to send the responses
     */
    global void execute(SchedulableContext schedulableInstance) {
        BatchResponse batchInstance = new BatchResponse();
        Database.executeBatch(batchInstance, 5);
    }
}