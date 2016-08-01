public with sharing class ContactList {
    public ContactList() {
        List<Contact> listContact=[SELECT Id ,name FROM Contact ];
        for(Contact c : listContact)
            System.debug(c+'\n \r');  
    }

}