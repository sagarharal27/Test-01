/**
 * SOAP API  -  web services assignment 
 */
global with sharing class SoapLeadManipulation {
    
    /**
     * Web Service to insert a lead
     */
    webService static SoapWrapLeadInformation createLead(
        String fNameInsert, 
        String lNameInsert,   
        String statusInsert, 
        String companyInsert, 
        String emailInsert, 
        String phoneInsert) {
        Lead leadInstance = new Lead();
        leadInstance.FirstName = fNameInsert;
        leadInstance.LastName = lNameInsert;
        leadInstance.Status = statusInsert;
        leadInstance.Company = companyInsert;
        leadInstance.Email = emailInsert;
        leadInstance.Phone = phoneInsert;
        SoapWrapLeadInformation wrapperInstance = new SoapWrapLeadInformation();
        try {
            insert leadInstance; 
            wrapperInstance.isSuccess = true; 
            wrapperInstance.leadId = leadInstance.Id; 
            wrapperInstance.status = 'Success';
        } catch(DmlException e) {
            wrapperInstance.isSuccess = false; 
            wrapperInstance.leadId = ''; 
            wrapperInstance.status = e.getMessage();
        }
        return wrapperInstance;
    }
    
    /**
     * Web Service to delete a lead
     */
    webService static SoapWrapLeadInformation deleteLead(
        String firstNameDelete,
        String lastNameDelete,
        String emailDelete,
        String phoneDelete
    ) {
        SoapWrapLeadInformation wrapperInstance = new SoapWrapLeadInformation();
        List<Lead> leadList = [
            Select 
                Id 
            From 
                Lead 
            Where 
                FirstName = :firstNameDelete
            AND
                LastName = :lastNameDelete
            AND 
                Email = :emailDelete
            AND
                Phone = :phoneDelete
        ];
       
        try {
            delete leadList; 
            wrapperInstance.isSuccess = true; 
            wrapperInstance.leadId = ''; 
            wrapperInstance.status = 'Success';
        } catch(DmlException e) {
            wrapperInstance.isSuccess = false; 
            wrapperInstance.leadId = ''; 
            wrapperInstance.status = e.getMessage();
        }
        return wrapperInstance;
    } 
     
    /**
     * Web Service to update a lead record
     */
    webService static SoapWrapLeadInformation updateLead( 
        String fNameUpdate, 
        String lNameUpdate, 
        String emailUpdate, 
        String phoneUpdate) {
        SoapWrapLeadInformation wrapperInstance = new SoapWrapLeadInformation();
        List<Lead> leadList = new List<Lead>([
            SELECT 
                Id, 
                FirstName 
            FROM 
                Lead 
            WHERE 
                FirstName = :fNameUpdate 
            AND 
                LastName = :lNameUpdate
        ]);
        if (!leadList.isEmpty()) {
                leadList[0].Phone = phoneUpdate;
                leadList[0].Email = emailUpdate;
            try { 
                update leadList[0];
                wrapperInstance.isSuccess = true; 
                wrapperInstance.leadId = leadList[0].Id; 
                wrapperInstance.status = 'Success';
            } catch(DmlException e) {
                wrapperInstance.isSuccess = false; 
                wrapperInstance.leadId = ''; 
                wrapperInstance.status = e.getMessage();
            }
        }
        return wrapperInstance;
    } 
    
    /**
     * Wrapper class to display fields after DML operations
     */
    global class SoapWrapLeadInformation {
        webservice Boolean isSuccess;
        webservice String leadId;
        webservice String status;
        
        /**
         * Initializating the variables
         */
        global SoapWrapLeadInformation() {
            isSuccess = false;
            leadId = '';
            status = '';
        }
    }
}