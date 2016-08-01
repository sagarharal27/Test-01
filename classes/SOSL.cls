//Find the word 'test' in all name fields returning Contact, Account, Lead and User.

public class SOSL 
{
    public SOSL()
    {
        list<List<SObject>> slist = [FIND 'test' IN NAME FIELDS 
                                     RETURNING contact(name), account(name),lead(name),user(name)];
        
        contact[] clist = ((List<contact>)slist[0]);
        account[] alist = ((List<account>)slist[1]);
        lead[] llist = ((List<lead>)slist[2]);
        user[] ulist = ((List<user>)slist[3]);
        
        for(contact c : clist)
            system.debug(c);
        
        for(account a : alist)
            system.debug(a);
        
        for(lead l:llist)
            system.debug(l);
            
        for(user u : ulist)
            system.debug(u);
    }

}