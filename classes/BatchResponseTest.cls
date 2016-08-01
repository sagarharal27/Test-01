/**
 * Test the batch class
 */
@isTest
private class BatchResponseTest { 
    
    /**
     * Test if responses are sent and the status of the record is updated or not 
     */
    static testMethod void sentResponsesTest() { 
        Query__c queryInstance = new Query__c(Name = 'test');
        insert queryInstance;
        
        // Check if insert of query is successful
        System.assert(queryInstance.id != null );
        
        Contact contactInstance = new Contact(Lastname = 'test', Email = 'test@demo.com');
        insert contactInstance;
        
        // Check if insert of query is successful
        System.assert(contactInstance.id != null);
        
        GoogleMockTest mockInstance = new GoogleMockTest();
        Test.setMock(HttpCalloutMock.class, mockInstance);
        
        Contact_Query_Junction__c junctionInstance = 
            new Contact_Query_Junction__c (
            QueryId__c = queryInstance.Id,
            ContactId__c = contactInstance.Id
        ); 
        insert junctionInstance;
        
        // Check for the size of the querylist
        System.assert(junctionInstance.id != null);
        
        Test.startTest();
        BatchResponse batchInstance = new BatchResponse();
        Database.executeBatch(batchInstance);
        Test.StopTest();
        
        List<Contact_Query_Junction__c> junctionListTest = [
            SELECT
                Id,
                Status__c
            FROM
                Contact_Query_Junction__c
            WHERE 
                Id = :junctionInstance.Id
        ];
        
        // Check if the mail is send or not
        System.assertEquals('Closed', junctionListTest[0].Status__c);
    }
}