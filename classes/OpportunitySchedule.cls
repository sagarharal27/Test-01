/**
 * Schedulable class to send email to an account everyday
 */
global with sharing class OpportunitySchedule implements schedulable {
     global void execute(SchedulableContext schedulableContext) {
        BatchApex BatchApexInstance = new BatchApex ();
        Database.executebatch(BatchApexInstance);
     }
}