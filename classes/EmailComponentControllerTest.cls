/**
 * Test the component controller
 */
@isTest
private class EmailComponentControllerTest {
    
    /**
     * Test if we are retriving the response list
     */
    static testMethod void responseListTest() {
        Query__c queryInstance = new Query__c(Name = 'Test');
        insert queryInstance;
        
        // Verify if the insert is successful
        System.assert(queryInstance.id != null);
        
        Response__c responseInstance = 
            new Response__c(
                Title__c = 'Test',
                QueryId__c = queryInstance.id,
                Link__c = 'www.test.com',
                Description__c =  'This is a test search '
            ); 
        insert responseInstance;
        
        // Verify if the insert is successful
        System.assert(responseInstance.id != null);
        
        EmailComponentController controllerInstance = new EmailComponentController();
        
        // Insert the query id in the response lookup
        controllerInstance.idQuery = queryInstance.id;
        
        Test.startTest();
        List<Response__c> responseList = controllerInstance.getResponseList();
        Test.stopTest();
        
        // Check if we are getting the responses
        System.assert(!responseList.isEmpty());
    }
}