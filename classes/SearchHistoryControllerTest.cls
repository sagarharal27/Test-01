/**
 * Test the controller of the Search history page
 */
@isTest
private class SearchHistoryControllerTest {
    
    /**
     * Test the next page
     */
    public static testMethod void nextPageTest() {  
        List<Query__c> queryList = new List<Query__c>();
        for (Integer i = 0; i < 20; i++) {
            Query__c queryInstance = new Query__c(Name = 'test' + i);
            queryList.add(queryInstance);
        }
        insert queryList;
        
        // Verify the inserted records
        for (Integer i = 0; i < 20; i++) {
            System.assert(queryList[i].id != null); 
        }
        
        Test.startTest();
        PageReference historyPageTest = Page.SearchHistory;
        Test.setCurrentPage(historyPageTest);
        SearchHistoryController controllerInstance = new SearchHistoryController();
        controllerInstance.next();
        Integer pageNumber = controllerInstance.setController.getPageNumber();
        Test.StopTest();
        
        // Check if we have navigated to the next page
        System.assertEquals(2, pageNumber); 
    }
    
    /**
     * Test the previous page
     */
    public static testMethod void previousPageTest() {  
        List<Query__c> queryList = new List<Query__c>();
        for (Integer i = 0; i < 30; i++) {
            Query__c queryInstance = new Query__c(Name = 'test' + i);
            queryList.add(queryInstance);
        }
        insert queryList;
        
        // Verify the inserted records
        for (Integer i = 0; i < 30; i++) {
            System.assert(queryList[i].id != null); 
        }
        
        Test.startTest();
        PageReference historyPageTest = Page.SearchHistory;
        Test.setCurrentPage(historyPageTest);
        SearchHistoryController controllerInstance = new SearchHistoryController();
        controllerInstance.next();
        controllerInstance.next();
        controllerInstance.previous();
        Integer pageNumber = controllerInstance.setController.getPageNumber();
        Test.StopTest();
        
        // Check if we have navigated to the next page
        System.assertEquals(2, pageNumber); 
    }
     
    /**
     * Test to verify if responses are retrived 
     */
    static testMethod void getRecordsTest() {
        Query__c queryInstance = new Query__c(Name = 'test');
        insert queryInstance; 
        
        // Verify the inserted record 
        System.assert(queryInstance.id != null); 
        
        Response__c responseInstance = new Response__c(
            Description__c = 'How to test my controller class',
            Link__c = 'test@demo.com',
            QueryId__c = queryInstance.id,
            Title__c = 'test'
            
        );
        insert responseInstance;
        
        // Verify the inserted record 
        System.assert(responseInstance.id != null); 
        
        PageReference historyPageTest = Page.SearchHistory;
        Test.setCurrentPage(historyPageTest);
        historyPageTest.getParameters().put('response', queryInstance.id );
        
        Test.startTest();
        SearchHistoryController controllerInstance = new SearchHistoryController();
        controllerInstance.responses();
        List<Response__c> responseListTest = controllerInstance.responseList;  
        Test.stopTest();
        
        // Check if we are retriving the queriesto be displayed on the page
        System.assert(!responseListTest.isEmpty());
         
    }
}