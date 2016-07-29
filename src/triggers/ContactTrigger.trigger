trigger ContactTrigger on Contact (after delete, after insert, after update, 
before delete, before insert, before update) {
     
     //Before Insert
     if(trigger.isBefore){
         
         if(trigger.isInsert){
             system.debug('Old records*******************'+ trigger.oldmap);
             system.debug('New records*******************'+ trigger.newmap); 
             //This trigger assigns Contact to Account if domain is same as website
             //when contact record is inserted
             //domainOfContactInAccount.assignAccountId(trigger.new);
             //This trigger avoids duplication of contact  
             //Avoid_duplication_contactHandler.DuplicateContact(trigger.new);
         }
         
         if(trigger.isUpdate){
            system.debug('Old records*******************'+ trigger.oldmap);
            system.debug('New records*******************'+ trigger.newmap);
            //This trigger assigns Contact to Account if domain is same as website
            //when contact record is updated
            domainOfContactInAccount.assignAccountId(trigger.new);
         }
         if(trigger.isDelete){
            system.debug('Old records*******************'+ trigger.oldmap);
            system.debug('New records*******************'+ trigger.newmap);
         }
     }
     //After trigger
     if(trigger.isAfter){
         if(trigger.isInsert){
             system.debug('Old records**********************'+ trigger.oldmap);
             system.debug('New records*******************'+ trigger.newmap);
         }
         if(trigger.isUpdate){
             system.debug('Old records*******************'+ trigger.oldmap);
             system.debug('New records*******************'+ trigger.newmap);
         }
         
         if(trigger.isDelete){
             system.debug('Old records*******************'+ trigger.oldmap);
             system.debug('New records*******************'+ trigger.newmap);
         }
     }
}