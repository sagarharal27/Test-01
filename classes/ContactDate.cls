/* Write a SOQL query to retrieve/print the Contact records 
* where Last Modified Date =Today
*/
public class ContactDate {
    public ContactDate() {
        list<Contact> dateContact = [Select c.id,c.name ,c.LastModifiedDate 
                                     From Contact c 
                                     where LastModifiedDate=TODAY];
            
        System.debug('\n\R'+dateContact);
    }
}