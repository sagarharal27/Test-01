trigger AccountTrigger on Account (after delete, after insert, after update, 
before delete, before insert, before update) {
    //Before Trigger
    if(trigger.isBefore){
        
        if(trigger.isInsert){
            system.debug('Old records********************'+ trigger.old);
            system.debug('New records********************'+ trigger.new);
            //avoidDuplicationOfWebsiteInAccount.DuplicateWebsite(trigger.new); 
        } 
        if(trigger.isDelete){ 
            system.debug('Old records****************'+ trigger.old);
            system.debug('New records*****************'+ trigger.new);
        }
        if(trigger.isUpdate){
             system.debug('Old records***********************'+ trigger.old);
            system.debug('New records*********************'+ trigger.new);
             //avoidDuplicationOfWebsiteInAccount.DuplicateWebsite(trigger.new);
        }
    }
    
    //After trigger
    if(trigger.isAfter){
        
        if(trigger.isInsert){
            system.debug('Old records********************'+ trigger.old);
            system.debug('New records********************'+ trigger.new);
            //This trigger create clone record of account
            //Account_clone_handler.CloningAccount(trigger.new);
        }
        if(trigger.isDelete){
            system.debug('Old records****************'+ trigger.old);
            system.debug('New records*****************'+ trigger.new);
        }
        if(trigger.isUpdate){
             system.debug('Old records***********************'+ trigger.old);
            system.debug('New records*********************'+ trigger.new);
        }
    }
}