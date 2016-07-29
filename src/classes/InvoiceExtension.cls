public with sharing class InvoiceExtension {
    ApexPages.StandardController sc;
    public InvoiceExtension(ApexPages.StandardController sc) {
        this.sc = sc;
    }
    public boolean comma = true;
    
    public void commaOnlyWhenRequired() {
        if(Invoice_statement__c.Customer_Name__c == null) {
            return true;
        }
        else {
            return false;
        }
    }
}