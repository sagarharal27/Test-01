/*    Write a SOQL query on Contact to retrieve all active contacts belonging to 'media' Industry. 
 *    Also display the name of the account to which it is associated to.
 *    Write SOQL query on 'C'(created above) to retrieve all records of 'C' with name 'John' along with parent details.
 */

public class ChildParent {
    public void ChildParent1() {
        list<Contact> con=[select id, name 
                           from Contact 
                           where Account.Industry ='Media'];
        system.debug(con);
        for(Contact c:con)
            System.debug(c);
        
    }
 
    
    public void ChildParent2()
    {
        list<C__c> c= [Select name, A__r.name, B__r.name 
                       FROM C__c 
                       where name like '%john%'];
        for(C__c cc : c )
            System.debug(cc);
    }
}