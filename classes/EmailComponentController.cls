/**
 * This is the controller for the VF component (email)
 */
public with sharing class EmailComponentController {
    
    public Id idQuery {get; set;}
    //public String nameQuery {get; set;}
    public List<Response__c> responseList;
    
    /**
     * Get the responses related the query 
     */
    public List<Response__c> getResponseList() {
        responseList = [
            SELECT 
                Id, 
                Title__c, 
                Link__c, 
                Description__c 
            FROM 
                Response__c 
            WHERE
                QueryId__c = :idQuery
        ];
        return responseList;
    }
}