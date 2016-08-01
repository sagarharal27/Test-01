public with sharing class AccountMap {
    public AccountMap() {
        list<Account> list1 =[Select a.Name, a.Id 
                              From Account a];
        system.debug(list1);
        map<String,Id> map1=new map<String,Id>();
        for(Account a : list1)
            map1.put(a.name,a.id);
        system.debug(map1);
        
       // PART B
        
        list<Account> list2 =[Select a.Name, a.Id 
                              From Account a];
        system.debug(list2);
        map<Id,Account> map2=new map<Id,Account>();
        for(Account acc : list2)
            map2.put(acc.Id,acc);
        system.debug(map2);
    }
}