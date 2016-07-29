/************************************************************************
 Class Name: ScheduleForOpportunity
 Created Date:8/8/2015
 Description: This schedular class for opportunity
*************************************************************************/ 

global with sharing class ScheduleForOpportunity implements Schedulable {
    
    global void  execute(SchedulableContext sc) {
       
        Database.executebatch(new CollectionOfClosedOpportunity());
        
    }  
    
}