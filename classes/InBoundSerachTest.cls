/**
 * Test class to check the inbound email functionality, trigger and handler class
 */
@isTest
private class InBoundSerachTest {
    
    /**
     * Test the email insert and the fire of the trigger with its handler class
     */
    static testMethod void emailInsertTest() {
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
        email.subject = 'test';
        env.fromAddress = 'demo@test.com';
        email.plainTextBody = 'how to test my';
        email.fromName = 'demo test';
        
        String subject = email.subject;
        String query = email.plainTextBody;
        
        GoogleMockTest mockInstance = new GoogleMockTest();
        Test.setMock(HttpCalloutMock.class, mockInstance);
        
        Test.startTest();
        InBoundSearchQueryMail instance = new InBoundSearchQueryMail();
        instance.handleInboundEmail(email, env); 
        Test.stopTest();
        
        List<Email_Information__c> emailList = [
            SELECT 
                Id 
            FROM
                Email_Information__c
            WHERE
                Subject__c = :subject
        ];
         
        // Check if the email has been inserted successfully
        System.assert(!emailList.isEmpty());
         
        
        List<Contact> contactListTest = [
            SELECT 
                Id,
                Name,
                Email 
            FROM
                Contact
        ]; 
        
        // Check if the contact has been inserted successfully
        System.assertEquals(1, contactListTest.size());
        
        List<Query__c> queryListTest = [
            SELECT 
                id 
            FROM 
                Query__c 
            WHERE 
                Name = :query
        ];
        
        //Check if there exist a unique query in the list
        System.assertEquals(1, queryListTest.size());
        
        List<Contact_Query_Junction__c> junctionList = [
            SELECT 
                Id 
            FROM
                Contact_Query_Junction__c
            WHERE
                ContactId__c = :contactListTest[0].id
            AND
                QueryId__c = :queryListTest[0].id
        ]; 
        
        // Check if the junction has been inserted successfully
        System.assertEquals(1, junctionList.size());
        
        List<Response__c> responseListTest = [
            SELECT 
                Id, 
                Name
            FROM 
                Response__c 
            WHERE
                QueryId__c = :queryListTest[0].id
        ];
         
        // Verify the we are getting the responses
        System.assert(!responseListTest.isEmpty()); 
    }
}