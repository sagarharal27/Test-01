public with sharing class sample {
    //public List<Query_Response__c> listQueryResponse;
    public Boolean flag {get; set;}
    public String searchString {get;set;}
    
    /**
     *  This is constructor for initialization
     */
    public sample() {
        flag = false;
    } // End of method
    
    /**
     *  This is method to retrieve all query string from org 
     */
    public List<Query__c> getqueryList() {
        return [SELECT Name 
                FROM Query__c
        ]; // Return list of query
    } // End of method 
    
    /**
     *  This is method to show details of particular query
     */
    public void showDetails() {
        searchString = apexpages.currentpage().getparameters().get('searchString');
        flag = true;
        System.debug('======searchString=====' + searchString);
       /* listQueryResponse = [SELECT Description__c,
                                    Link__c,
                                    Title__c 
                             FROM Query_Response__c 
                             WHERE Query__r.Search_String__c = :searchString
                            ];*/
        //System.debug('======listQueryResponse=====' + listQueryResponse);
       // return listQueryResponse;
    } // End of method 
    
    /**
     *  This is method to return list of responses related to particular query
     */
   /* public List<Query_Response__c> getshowDetailsOfQuery() {
        showDetails();
        return listQueryResponse;
    } // End of method
    
    /**
     *  This is method for pagination 
     */
    public ApexPages.StandardSetController setCon {
       get {
            if (setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                      [SELECT Name FROM Query__c]));
            }
            return setCon;
        }
        set;
    } // End of method
    /**
     *  This is method to initialize setCon method and return a list of records
     */
    public List<Query__c> getQueries() {
         setCon.setpagesize(5);
         return (List<Query__c>) setCon.getRecords();
    } // End of method
} // End of class
    
   
//}