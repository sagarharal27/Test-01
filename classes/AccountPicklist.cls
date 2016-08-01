public with sharing class AccountPicklist {
    public AccountPicklist() {
        list<Account> list2 =[Select a.Name, a.Id, a.Enrollment_Year__c 
                              From Account a 
                              where a.Enrollment_Year__c 
                              INCLUDES ('2013','2014') ];
       
        list<Account> list1 =[Select a.Name, a.Id, a.Enrollment_Year__c 
                              From Account a 
                              where a.Enrollment_Year__c ='2010' ];
        //system.debug(list1);
        system.debug(list2);
    }
}

/*
IN gives one and only
does not return if both exist
(Account:{Name=microsoft, Id=001280000057CxrAAE, Enrollment_Year__c=2013})


INCLUDES gives one or more
(Account:{Name=gmail, Id=001280000057CxcAAE, Enrollment_Year__c=2013;2014},
 Account:{Name=microsoft, Id=001280000057CxrAAE, Enrollment_Year__c=2013})

*/