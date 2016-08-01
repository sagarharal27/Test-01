/**
 * Web Service using Rest API
 * Perform insert update and delete operations 
 */
@RestResource(urlMapping = '/LeadManipulation/*')
global with sharing class RestLeadManipulation {
    
    /**
     * HttpPost is used to insert a lead record
     */
    @HttpPost
    global static RestWrapLeadInformation createLead(
        String firstNameInsert, 
        String lastNameInsert, 
        String companyInsert, 
        String statusInsert, 
        String emailInsert, 
        String phoneInsert) { 
        Lead leadInstance = new Lead(); 
        leadInstance.FirstName = firstNameInsert; 
        leadInstance.LastName = lastNameInsert; 
        leadInstance.Company = companyInsert;
        leadInstance.Email = emailInsert;
        leadInstance.Phone = phoneInsert; 
        leadInstance.Status = statusInsert; 
        RestRequest restRequestInstance = RestContext.request;
        
        // Wrapper class instance 
        RestWrapLeadInformation wrapperInstance = new RestWrapLeadInformation(); 
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
     * HttpDelete is used to delete a lead record
     */ 
    @HttpDelete 
    global static RestWrapLeadInformation deleteLead() {
        RestRequest getParameter = RestContext.request;
        String fNameDelete = getParameter.params.get('FirstName');
        String lNameDelete = getParameter.params.get('LastName');
        String emailDelete = getParameter.params.get('Email');
        String phoneDelete = getParameter.params.get('Phone');
        List<Lead> leadListDelete = [ 
            SELECT 
                Id  
            FROM 
                Lead 
            WHERE 
                FirstName = :fNameDelete 
            AND
                LastName = :lNameDelete
            AND
                Email = :emailDelete
            AND
                Phone = :phoneDelete
        ];
        System.debug(leadListDelete);
        RestWrapLeadInformation wrapperInstance = new RestWrapLeadInformation();
        try { 
            delete leadListDelete;
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
     * HttpPatch is used to update a lead record
     */
    @HttpPatch
    global static RestWrapLeadInformation leadUpdate(
        String firstNameUpdate,
        String lastNameUpdate,
        String emailUpdate,
        String phoneUpdate) {
        List<Lead> leadListUpdate = new List<Lead>();
        leadListUpdate = [
            SELECT 
                Id 
            FROM 
                Lead 
            WHERE 
                FirstName = :firstNameUpdate
            AND
                LastName = :lastNameUpdate
        ];
         
        RestWrapLeadInformation wrapperInstance = new RestWrapLeadInformation();
        for (Lead leadInstance : leadListUpdate) {
            leadInstance.Email = emailUpdate;
            leadInstance.Phone = phoneUpdate;
            
        }
        try {
            update leadListUpdate;
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
     * Wrapper class to display fields after DML operations
     */
     global class RestWrapLeadInformation {
         public Boolean isSuccess;
         public String leadId;
         public String status;
         
         /**
          * Initializating the variables
          */
         public RestWrapLeadInformation() {
            isSuccess = false;
            leadId = '';
            status = '';
            
         }
     }
}