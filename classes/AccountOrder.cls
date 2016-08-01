public with sharing class AccountOrder {
    public AccountOrder() {
        list<Account> listacc1= [select Id,name,Billing_State__c from account 
                                 where Billing_State__c NOT IN('Maharashtra','Kerala') 
                                 ORDER by Billing_state__c DESC nulls last 
                                 limit 10000];
        system.debug(listacc1);
    }
}