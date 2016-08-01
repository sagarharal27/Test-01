/**
 * This is the handler class of the trigger on the Contact_Query_Junction__c object (After insert)
 */
public with sharing class QueryHandler {
    
    public String queryLine;
    
    /**
     * Get the inserted list of queries
     */
    public QueryHandler(List<Contact_Query_Junction__c> queryList) {
        List<String> queryIdList = new List<String>();
        for (Contact_Query_Junction__c junctionInstance : queryList) {
            queryIdList.add(junctionInstance.QueryId__c);
        }
        List<Query__c> listOfQuery = [
            SELECT 
                Id,
                Name
            FROM 
                Query__c 
            WHERE 
                Id IN :queryIdList
        ];  
        for (Query__c queryField : listOfQuery) {
            googleCall(queryField.Name); 
        }
    }
     
    /**
     * Call out to google API and insert the responses 
     */
    @future (callout = true)
    public static void googleCall(String query) {
        
        HttpRequest request = new HttpRequest();
        String queryString = query;
        request.setEndpoint(
            'https://www.google.com/search?q=' + 
            EncodingUtil.urlEncode(queryString, 'UTF-8')
        );
        request.setMethod('GET');
        request.setHeader('Content-Type', 'text/plain');
        Http http = new Http();
        HttpResponse response = http.send(request);
        
        // Check if query exist  
        List<Query__c> queryList = [
            SELECT 
                Id
            FROM 
                Query__c 
            WHERE 
                Name = :query
        ];   /// QUERY ID
        
        System.debug('in FUTURE' + queryList);
        
        List<Response__c> finalList = new List<Response__c>();
        List<Response__c> insertList = new List<Response__c>();
        List<String> responseList = new List<String>();
        responseList = response.getBody().split('<li class="g">');
        
        for (String responseInstance : responseList) {
            Response__c insertResponse = new Response__c();
            
            insertResponse.QueryId__c = queryList[0].Id;
            insertResponse.Title__c = responseInstance.substringBetween('<b>', '</a>');
            if (String.isNotBlank(insertResponse.Title__c) == true) {
                insertResponse.Title__c = insertResponse.Title__c.stripHtmlTags();
            }
        
            insertResponse.Link__c = 
                responseInstance.substringBetween('<a href="/url?q=', '&amp;');
            
            String description1 = 
                responseInstance.replace(
                '<span class="st">', 
                'tratsNoitpircsed'
            );
            String description2 = 
                description1.replace( 
                '</span>', 
                'dneNoitpircsed'
            );
            String description3 = description2.stripHtmlTags();
            String description4 = 
                description3.substringBetween(
                'tratsNoitpircsed', 
                'dneNoitpircsed'
            );
            insertResponse.Description__c = description4;
            insertList.add(insertResponse);
        }
        
        insertList.remove(0);
        List<Response__c> listOfResponses = [
            SELECT 
                Link__c 
            FROM
                Response__c 
        ];
        
        // Set for all unique responses
        Set<String> responseSet = new Set<String>();
        for(Response__c instance : listOfResponses){
            responseSet.add(instance.Link__c);
        }
        
        for (Response__c instance : insertList) {
            if (!responseSet.contains(instance.Link__c)) {
                finalList.add(instance);
            }
        }
        insert finalList;
    }
}