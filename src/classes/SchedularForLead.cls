global with sharing class SchedularForLead implements Schedulable{
  
    global void  execute(SchedulableContext sc) {
        
        List<CronTrigger> listCronTrigger = [select Id from CronTrigger];
        
        System.schedule('JobLead'+system.now(),' 0 0 /3  *  * ? ',new SchedularForLead());
        Database.executebatch(new AvoidDuplicationOfLead());
    }
<<<<<<< HEAD
}
=======
} 
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
