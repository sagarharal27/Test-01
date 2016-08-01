//   Add all Account Id’s to the set and print the result
// c. Prepare the Map having Key as OpportunityId and Value as AccountId

public class OpportunityDemo 
{
    public OpportunityDemo()
    {
        Set <Id> accSet= new Set <Id>();
        List <Id> oppList= new List <Id>();
        Map <Id,Id> OppAccMap = new Map<Id,Id>();
        
        List<Opportunity> opportunityList= [Select Id,Account.Id 
                                    from Opportunity 
                                    where AccountID != NULL 
                                    and StageName = 'Closed Won' ];

           
        for(Opportunity op : opportunityList)
        {    
           oppList.add(op.Id);
           accSet.add(op.Account.Id);
           OppAccMap.put(op.Id,op.Account.Id);
           
        }
        
        System.debug(oppList);
        System.debug(accSet);
        System.debug(OppAccMap);
        
        
        
    }

}