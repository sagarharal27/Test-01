/**
 * BEFORE TRIGGER
 * Trigger is on Contact object and returns contact record before inserting
 */
trigger BestPracticeTrigger on Contact(before insert, after insert) {
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            BestPracticeTriggerHandler bestHandlerInstance = 
                new BestPracticeTriggerHandler(Trigger.new);
        }
    }
}