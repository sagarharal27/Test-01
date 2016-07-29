public with sharing class Count_contact_havingName_Eternus {
 integer no;
    public void m1 ()
    {
        Map<Id, List<contact>> mymap= new Map<Id, List<contact>>();
        List<Contact> mylist =[select Account.Id, Name From Contact where Account.Name = 'Eternus'];
        for(Contact con : mylist)
        {
            If(mymap.containsKey(con.Account.Id))
            {
                mymap.get(con.Account.Id).add(con);
            }
            else
            {
                mymap.put(con.Account.Id,new list<contact>{con});
            }
            system.debug(mymap.get(con.account.id));
        }
         
        list<Account> accountList = new list<Account>();
        for(id setid: mymap.keyset())
        {
           accountList.add( new Account (id=setid,contact_count__c=mymap.get(setid).size()));  
        }
         if(accountList.size() > 0)
          update accountList;
                            
        
        
    }
    
}