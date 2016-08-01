/**Task Creation Trigger
  *Create a task upon successful creation of a new Account.
  *The task subject should be set as –Meeting with <specific Account’s name>.
  *Should be bulk safe in nature and must be capable of handling at least 200 records at a time.
  */
  
// Trigger on account object after insert
trigger TaskCreationTrigger on Account (after insert) {
    if(trigger.isAfter) {
        if(trigger.isInsert) {
            // pass the inserted values to the handler class
            TaskCreationHandler taskHandlerInstance = new TaskCreationHandler(trigger.new);
        }
    }
}