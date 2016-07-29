public with sharing class avoidDuplicationOfWebsiteInAccount {
    

    public static void DuplicateWebsite(List<Account> accountList) {
        //map of email as key and boolean value
        map <string,boolean> mapWebsite=new map <string,boolean>();
        
        for (Account accnInstance:accountList) {
            mapWebsite.put(accnInstance.Website,true);
           
        }
        for(Account acc:[select website from Account 
                         where website IN:mapWebsite.keySet()]) {
        
            mapWebsite.put(acc.website,false);
        }
        for (Account accnInstance:accountList) {
            if(mapWebsite.get(accnInstance.website)== false) {
                accnInstance.adderror('Duplication website is inserted');
            }
        }
    }
}