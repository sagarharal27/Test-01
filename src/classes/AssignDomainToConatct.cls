public with sharing class AssignDomainToConatct {
        
        /*public static void assignAccountId(List<Contact> listOfContact){
            
            map<string,id> mapOfSiteAndAccountId=new map<string,id>();
            
            List<Account> lstAcc=[SELECT Id, Website
                                    FROM Account 
                                    WHERE Website <> Null];
           mapOfSiteAndAccountId.put(lstAcc.website,lstAcc.Id);
                                    
            for(Contact conInstance:listOfContact) {
                
                if(mapOfSiteAndAccountId.containsKey(conInstance.Domain__c)) { 
                
               conInstance.AccountId=mapOfSiteAndAccountId.get(conInstance.Domain__c);
            }
        }
        
}*/
}