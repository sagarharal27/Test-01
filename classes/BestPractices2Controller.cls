public with sharing class BestPractices2Controller {
    public Id invoiceId{get;set;}
    public list<Invoice_Statement__c> listInvoice;
    public list<Line__c> lineItems;
    public PageReference newPage() {
        PageReference bill = Page.PdfBill;
        bill.getParameters().put('iId', invoiceId);
        bill.setRedirect(true);   
        return bill;       
    }
    public list<Invoice_Statement__c> getlistInvoice() {
      // invoiceId = ApexPages.currentPage().getParameters().get('iid');
     
    listInvoice=[Select i.Name, i.Id, i.CreatedDate 
                  From Invoice_Statement__c i];
                                     
       System.debug(listInvoice); 
       return listInvoice;
    }
    /*
    public list<Line__c> getlineItems() {
        invoiceId = ApexPages.currentPage().getParameters().get('iid');
        lineItems=[Select l.Unit_Sold__c, l.Unit_Price__c, l.Name, l.Merchandise_Name__c, l.Invoice_Statement__c 
                   From Line__c l where Invoice_Statement__c =  :invoiceId ];
        
        /*
        if(!lineItems.isEmpty) {
            return lineItems;
        }
        else {
            return NULL;
        }
    }*/
}