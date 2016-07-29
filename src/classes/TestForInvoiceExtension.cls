/**************************************************************************************************
Class : TestForInvoiceExtension
Date : 26/8/2015
Description : This is test class to test an extension for Invioce Process page
***************************************************************************************************/
@isTest
public class TestForInvoiceExtension {

    // Method to test Customer name
    static testMethod void testCustomerName() {
        // Initializing Object
        Invoice_statement__c invoiceObj = new Invoice_statement__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(invoiceObj);
        ExtensionForInvoice instance = new ExtensionForInvoice(sc);
        invoiceObj = (Invoice_statement__c)sc.getRecord();
        
        // Inserting customer name
        invoiceObj.Customer_Name__c = 'Pooja';
        insert invoiceObj;
        instance.commaOnlyWhenRequired();
        // Checking actual value and expected value
        System.assertEquals(invoiceObj.Customer_Name__c,'Pooja,');
    }
    // Method to test Company name
    static testMethod void testCompanyName() {
         // Initializing Object
        Invoice_statement__c invoiceObj = new Invoice_statement__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(invoiceObj);
        ExtensionForInvoice instance = new ExtensionForInvoice(sc);
        invoiceObj = (Invoice_statement__c)sc.getRecord();
        
        // Inserting Company name
        invoiceObj.Company_name__c = 'Eternus';
        insert invoiceObj;
        instance.commaOnlyWhenRequired();
        // Checking actual value and expected value
        System.assertEquals(invoiceObj.Company_name__c,'Eternus,');
    }
    // Method to test address 
    static testMethod void testAddress() {
        Invoice_statement__c invoiceObj = new Invoice_statement__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(invoiceObj);
        ExtensionForInvoice instance = new ExtensionForInvoice(sc);
        invoiceObj = (Invoice_statement__c)sc.getRecord();
        
        // Inserting address
        invoiceObj.Street_Address__c = 'Pune';
        insert invoiceObj;
        instance.commaOnlyWhenRequired();
        // Checking actual value and expected value
        System.assertEquals(invoiceObj.Street_Address__c,'Pune,');
    }
    // Method to test city 
    static testMethod void testCity() {
        Invoice_statement__c invoiceObj = new Invoice_statement__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(invoiceObj);
        ExtensionForInvoice instance = new ExtensionForInvoice(sc);
        invoiceObj = (Invoice_statement__c)sc.getRecord();
        
        // Inserting city
        invoiceObj.City__c = 'Pune';
        insert invoiceObj;
        instance.commaOnlyWhenRequired();
        // Checking actual value and expected value
        System.assertEquals(invoiceObj.City__c,'Pune,');
    }
    // Method to test state
    static testMethod void testState() {
        Invoice_statement__c invoiceObj = new Invoice_statement__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(invoiceObj);
        ExtensionForInvoice instance = new ExtensionForInvoice(sc);
        invoiceObj = (Invoice_statement__c)sc.getRecord();
        
        // Inserting state
        invoiceObj.State__c = 'Maharashtra';
        insert invoiceObj;
        instance.commaOnlyWhenRequired();
        // Checking actual value and expected value
        System.assertEquals(invoiceObj.State__c,'Maharashtra,');
    }
    // Method to test phone
    static testMethod void testPhone() {
        Invoice_statement__c invoiceObj = new Invoice_statement__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(invoiceObj);
        ExtensionForInvoice instance = new ExtensionForInvoice(sc);
        invoiceObj = (Invoice_statement__c)sc.getRecord();
        
        // Inserting phone
        invoiceObj.Phone__c = '123456';
        insert invoiceObj;
        instance.commaOnlyWhenRequired();
        // Checking actual value and expected value
        System.assertEquals(invoiceObj.Phone__c,'123456,');
    }
    // Method to test Email
    static testMethod void testEmail() {
        Invoice_statement__c invoiceObj = new Invoice_statement__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(invoiceObj);
        ExtensionForInvoice instance = new ExtensionForInvoice(sc);
        invoiceObj = (Invoice_statement__c)sc.getRecord();
        
        // Insertin email
        invoiceObj.Email_Address__c = 'pooja@gmail.com';
        insert invoiceObj;
        instance.commaOnlyWhenRequired();
        // Checking actual value and expected value
        System.assertEquals(invoiceObj.Email_Address__c,'pooja@gmail.com,');
    }
} 
    
    