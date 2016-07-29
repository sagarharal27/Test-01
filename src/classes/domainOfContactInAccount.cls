/*****************************************************************************************
 Class Name: domainOfContactInAccount
 Created Date:20/7/2015
 Description: This Handler class automatically associate a Contact
              with the respective Account based on the email domain
*******************************************************************************************/

public with sharing class domainOfContactInAccount {
    //initiate List of contact in method
    public static void assignAccountId(List<Contact> listOfContact) {
        //Creating map of Domain as a key and List of Id as value
        Map<String, set<Id>> mapContact = new Map<String, set<Id>>();
            //Itereting list
            if(listOfContact!=null && !listOfContact.isEmpty()) {
                for(Contact conInstance:listOfContact) {
                
                    if(conInstance.AccountId==Null) {
                    
                        //If map is having Domain as key
                        if(mapContact.containsKey(conInstance.Domain__c)) {
                        
                            //put the value(contact Id) in that key
                            mapContact.get(conInstance.Domain__c).add(conInstance.Id);
                        }
                        else{
                            //else put the key and its value to the map
                            mapContact.put(conInstance.Domain__c,new set<Id>{conInstance.Id});
                        }
                    }
                }
            }
            else{
                system.debug('No records..');
                }
          
        //Initialise map having String as key and id as values
        Map<String, Id> mapOfSiteAndAccountId = new Map<String, Id>();
        for(Account accInstance:[SELECT Id, Website
                                    FROM Account 
                                    WHERE Website <> Null]) {
            
            //Assigning website to string 
                            
            string strDomain= 'http://' +accInstance.Website;
            mapOfSiteAndAccountId.put(strDomain,accInstance.id);
        }
        //displaying map
        system.debug('....Map' +mapOfSiteAndAccountId);
        
        if(listOfContact!=null && !listOfContact.isEmpty()) {
            for(Contact conInstance :listOfContact){
                system.debug('....Site' +conInstance.Domain__c);
            
                if(mapContact.containsKey(conInstance.Domain__c)) { 
                    conInstance.AccountId=mapOfSiteAndAccountId.get(conInstance.Domain__c);
                }
            }
        }
        else{
            system.debug('No records found');
        }
    }
}