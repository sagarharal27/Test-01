/* Prepare the Map structure to show the Account (As key) and 
* Its opportunities as list(Value)
* Hint : Query on Account and get the child opportunities or
* Query on Opportunities and get the parent Account Id
* Hint : Your map structure will be : Map<Id,List<Id>>
*/
public class MapDemo {
	public MapDemo() {
        List<Account> accountList = [Select a.Name, a.Id,
                                     (Select Id, Name From Opportunities) 
                                 	 From Account a];
        Map<Id, List<Opportunity>> mapAccount= new Map<Id, List<Opportunity>>();
        for(Account accountInstance : accountList)
            mapAccount.put(accountInstance.Id, accountInstance.Opportunities);
        for(ID ids : mapAccount.keySet())
        System.debug(mapAccount.get(ids));
    }
}