/**************************************************************************************************
Class : ExtensionForInvoice
Date : 24/8/2015
Description : This is extension for invoice processing
*************************************************************************************************/

public with sharing class ExtensionForInvoice {
    
    ApexPages.StandardController sc;
    public Invoice_statement__c invoiceObj;
    public String strCommaOperator{get; set;}
    public String strCustomerName{get; set;}
    public String strCompanyName{get; set;}
    public String strStreetAddress{get; set;}
    public String strCityName{get; set;}
    public String strStateName{get; set;}
    public String strPhoneName{get; set;}
    public String strEmailName{get; set;}
    //public String StringZip{get; set;}
    
    public ExtensionForInvoice(ApexPages.StandardController sc) {
        invoiceObj = new Invoice_statement__c();
        this.sc = sc;
        invoiceObj = (Invoice_statement__c)sc.getRecord();
        System.debug('/*/*/*/*/*/*/*/* RECORD>>>>>>>>>>>>  : '  );
        strCommaOperator = ',';
        strCustomerName = ''; 
        strCompanyName = '';
        strStreetAddress = '';
        strCityName = '';
        strStateName = '';
        strPhoneName = '';
        strEmailName = '';
        // StringZip = '';
    }
    
    // Method to add comma operator on condition
    public void commaOnlyWhenRequired() {
        System.debug('/*/*/*/*/*/*/*/* RECORD IN METHOD : ' + invoiceObj);
        
        // If Customer name is not empty
        if(String.isNotBlank(invoiceObj.Customer_Name__c)) {
            // Add comma
            invoiceObj.Customer_Name__c = invoiceObj.Customer_Name__c + strCommaOperator;
        }
        // If Company name is not empty
        if(invoiceObj.Company_name__c !='' && invoiceObj.Company_name__c != null) {
            // Add comma
            invoiceObj.Company_name__c = invoiceObj.Company_name__c + strCommaOperator;
        }
        // If Street address is not empty
        if(invoiceObj.Street_Address__c !='' && invoiceObj.Street_Address__c != null) {
             // Add comma
            invoiceObj.Street_Address__c = invoiceObj.Street_Address__c + strCommaOperator;
        }
        // If Street City is not empty
        if(invoiceObj.City__c !='' && invoiceObj.City__c != null) {
             // Add comma
            invoiceObj.City__c = invoiceObj.City__c + strCommaOperator;
        }
        // If Street State is not empty
        if(invoiceObj.State__c !='' && invoiceObj.State__c != null) {
            // Add comma
            invoiceObj.State__c = invoiceObj.State__c + strCommaOperator;
        }
        /*if(invoiceObj.Zip_code__c !='' && invoiceObj.Zip_code__c != null) {
             StringZip = String.ValueOf(invoiceObj.Zip_code__c);         
             StringZip = StringZip + commaOp; 
        } */
        // If Phone is not empty
        if(invoiceObj.Phone__c !='' && invoiceObj.Phone__c != null) {
            // Add comma
            invoiceObj.Phone__c = invoiceObj.Phone__c + strCommaOperator;
        }
        // If Email is not empty
        if(invoiceObj.Email_Address__c !='' && invoiceObj.Email_Address__c != null) {
            // Add comma
            invoiceObj.Email_Address__c = invoiceObj.Email_Address__c + strCommaOperator;
        }
    }
}