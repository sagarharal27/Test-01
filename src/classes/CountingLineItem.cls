public with sharing class CountingLineItem {
    ApexPages.StandardController sc;
    
    public CountingLineItem(ApexPages.StandardController sc) {
        this.sc = sc;
    }
    
    public void countOfLineItem(){
        List<Invoice_statement__c> ListInvoice=[Select i.Id, 
                                                (Select Id From Line_Items__r)
                                                From Invoice_statement__c i];
        
        
        for(Invoice_statement__c inst:ListInvoice) {
            integer counter=0;
            for(Line_Item__c line:inst.Line_Items__r){
                counter++;
                
            }
        }
        if(counter=0){
            sc.display();  
        }
    }
}