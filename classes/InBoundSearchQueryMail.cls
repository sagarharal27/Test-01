/**
 * Class will handle the emails
 */
global class InBoundSearchQueryMail implements Messaging.InboundEmailHandler {
    
    /**
     * The Incoming mail will be decoded and will be inserted into respective objects
     */
    global Messaging.InboundEmailResult handleInboundEmail(
        Messaging.InboundEmail email, 
        Messaging.Inboundenvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        Contact contactInstance;
        Query__c queryInstance;
        Contact_Query_Junction__c junctionInstance = new Contact_Query_Junction__c();
        
        // Get all the values in variables
        String senderMailId = email.fromAddress; 
        String senderName = email.fromName;
        String mailSubject = email.Subject;
        String mailBody = email.plainTextBody;
        
        // Extracting the query from the body
        String query = mailBody;
        query = query.abbreviate(103);
        query = query.removeEnd('...').trim();
        
        // Insert the incoming mail in to the Email_Information__c object
        Email_Information__c emailInstance = 
            new Email_Information__c(
            Sender_Mail_Id__c = senderMailId, 
            Subject__c = mailSubject, 
            Body__c = mailBody 
            );
        insert emailInstance;
        
        // Check if contact exist 
        List<Contact> contactList = [
            SELECT 
                Id 
            FROM
                Contact
            WHERE
                Email = :senderMailId
        ];  /// CONTACT ID 
        
        // Check if query exist  
        List<Query__c> queryList = [
            SELECT 
                id 
            FROM 
                Query__c 
            WHERE 
                Name = :query
        ];   /// QUERY ID
        
        // Check if query exist in database
        if (queryList.isEmpty()) {
            queryInstance = new Query__c(Name = query);
            insert queryInstance;
        }
        
        // If contact does not exist then create a new contact
        if (contactList.isEmpty()) {
            contactInstance = 
                new Contact(
                Lastname = senderName, 
                Email = senderMailId
            );
            insert contactInstance;  //   CONTACT ID
            junctionInstance.ContactId__c = contactInstance.Id;
            junctionInstance .QueryId__c = queryInstance.Id;
        } else if (!contactList.isEmpty() && queryList.isEmpty()) {
            junctionInstance.ContactId__c = contactList[0].Id;
            junctionInstance .QueryId__c = queryInstance.Id;
        } else if (!contactList.isEmpty() && !queryList.isEmpty()) {
            junctionInstance.ContactId__c = contactList[0].Id;
            junctionInstance .QueryId__c = queryList[0].Id;
        }
        insert junctionInstance;
        return result;
    }
}