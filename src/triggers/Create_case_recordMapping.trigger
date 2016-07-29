/************************************************************************
 Trigger Name: Create_case_recordMapping
 Created Date:20/7/2015
 Description: This trigger fires when EFT record is created
*************************************************************************/  
trigger Create_case_recordMapping on EFT_Transaction_Status__c (after insert) {
    if(trigger.isAfter && trigger.IsInsert) {   
        //calling method of handler
        //Create_case_mappingHandler = new Create_case_mappingHandler(); 
        system.debug('))))))))))))))))))))))))))))))))))))');
        Create_case_mappingHandler.createCase(trigger.new); 
        
        }
    } 