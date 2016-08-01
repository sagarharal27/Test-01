/* Parent-Child 3
 *
 *Write a SOQL query on 'A' and retrieve all parents with 
 *all their child records where in child name is 'John'.
 */
 
public class AllParents {
    public AllParents() {
          list<A__c> myList = [Select a.Name, a.Id, 
                               (Select Name From C__r) 
                               From A__c a where  A__c.id 
                               IN (Select A__c
                               from C__c where Name Like '%john%')];
          for(A__c aObj : myList){
              system.debug(aObj);
              for(C__c  cObj: aObj.C__r)
                  system.debug(cObj);
           }
     }
}