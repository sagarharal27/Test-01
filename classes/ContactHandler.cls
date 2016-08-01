public with sharing class ContactHandler {
    public void updatePrimaryContactOnAccount(List<Contact> contactParameter) {
        List<Account> accountObject = new List<Account>();
        //Account accountobj = new Account();
        for (Contact contactInstance : contactParameter) {
            if (contactInstance.AccountId <> null && contactInstance.Email <> NULL  && 
                contactInstance.Primary_Contact__c == true) {
                accountObject.add(new Account(id = contactInstance.AccountId, 
                    Primary_Email__c = contactInstance.Email ));
            }
        }
        update accountObject;
    }
}