/**
  *Task Creation Trigger
  *Create a task upon successful creation of a new Account.
  *The task subject should be set as –Meeting with <specific Account’s name>.
  *Should be bulk safe in nature and must be capable of handling at least 200 records at a time.
  *
  */

public with sharing class TaskCreationHandler {
    // Constructor
    public TaskCreationHandler(List<Account> accountParameter) {
        List<Task> taskList=new List<Task>();
        // Iterate over the account list
        for (Account accountinstance : accountParameter ) {
            taskList.add(new Task(Subject='Meeting with ' + accountinstance.Name));
        }
        // Check if list is empty
        if (!taskList.isEmpty()) {
            insert taskList;
        }
    }
}