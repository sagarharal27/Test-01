/*Write a SOQL query to display 100 opportunity records 
 *with amount greater than 10,000 order by created date. 
 *skip first 50 records and include records from recycle bin. 
 */

public with sharing class OpportunityAmount {
    public OpportunityAmount() {       
        list<Opportunity> oppList= [Select o.CreatedDate, o.Amount, o.AccountId From Opportunity o 
                                     where o.Amount > 10000 
                                     ORDER BY  o.CreatedDate ASC 
                                     OFFSET 20 ALL ROWS];
        system.debug(oppList);
    }

}