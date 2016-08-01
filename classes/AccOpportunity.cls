/*Write a SOQL query to find all Account records 
 *which have at least an opportunity record which is 'Closed Won'.
*/
public class AccOpportunity {
    public AccOpportunity() {
        // Constructor
        List<Account> accountList = [SELECT a.Name, a.Id, 
                                     (SELECT Id, StageName 
                                      FROM Opportunities)
                                     FROM Account a 
                                     WHERE  a.id 
                                     IN 
                                     (SELECT AccountId
                                      FROM Opportunity 
                                      WHERE StageName='Closed Won')];
        for(Account accountInstance : accountList) {
            for(Opportunity opportunityInstance: accountInstance.Opportunities)
                system.debug(opportunityInstance);
        }
    }
}