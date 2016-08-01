/*Write a SOQL query on Account and find all associated contact records
 *of the Account which contains the word 'John'. 
 *Print all Account and Contact records retrieved above.
 */
 
public with sharing class AccountContact {
    // Constructor
    public AccountContact() {
        // Account related contacts
        list<Account> accountContactList = [SELECT a.Name,a.Id,
                                            (SELECT Name FROM Contacts)
                                            FROM Account a 
                                            WHERE a.Id 
                                            IN
                                            (SELECT AccountId 
                                            FROM Contact
                                            WHERE Name 
                                            LIKE '%john%') ];     
        // Print the result
        for (Account accountInstance : accountContactList) {
            for (contact contactInstance: accountInstance.contacts) {
                System.debug(contactInstance);
            } // Inner for         
         } // Outer for
     } // Constructor
} // Class