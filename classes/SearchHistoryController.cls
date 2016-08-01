/**
 * Controller class to display all the queries and the responses of the selected query
 */
public with sharing class SearchHistoryController {
    
    public Id queryId;
    public List<Response__c> responseList {get; set;}
    
    public List<Query__c> QueryList {
        get{
            System.debug('\n\n\n\n\n QUERY LIST');
            return (List<Query__c>) setController.getRecords();
        } 
        set;
    }
    
    public ApexPages.StandardSetController setController {
        get{
            if(setController == null) {
                setController = new ApexPages.StandardSetController(
                    Database.getQueryLocator([
                        Select Name FROM Query__c]
                    )
                );  
                setController.setPageSize(10);
            }
            return setController;
        }
        set;
    }
    
    /**
     * Navigate to the next page
     */
    public void next() {
        setController.next();
    }
    
    /**
     * Navigate to the previous page
     */
    public void previous() {
        setController.previous();
    }
    
    /**
     * Get the responses related to the query
     */
    public void responses() {
        
        // Get the parameters fromm the page 
        queryId = ApexPages.currentPage().getParameters().get('response');
        responseList = [
            SELECT 
                Id,
                Name,
                Title__c,
                Link__c,
                Description__c
            FROM
                Response__c
            WHERE
                QueryId__c = :queryId 
        ];
    }
}