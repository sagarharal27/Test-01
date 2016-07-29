@RestResource(urlMapping = '/LeadManipulation/')
global with sharing class RestLeadManipulation {

    //HttpPost is used to insert a lead record
    //Inserting a lead record
    @HttpPost
    global static RestWrapLeadInformation createLead(String strInsertFirstName, String lastNameInsert, 
                                                     String companyInsert, String statusInsert, 
                                                     String phoneInsert) { 

        Lead leadObj = new Lead(); 
        leadObj.FirstName = strInsertFirstName; 
        leadObj.LastName = strlastInsertName; 
        leadObj.Company = strInsertcompany; 
        leadObj.Phone = strInsertphone; 
        leadObj.Status = strInsertstatus; 
        RestRequest restRequestInstance = RestContext.request;

        // Wrapper class instance 
        RestWrapLeadInformation wrapperInstance = new RestWrapLeadInformation(); 
        try {
            insert leadInstance;
            wrapperInstance.isSuccess = true; 
            wrapperInstance.leadId = leadInstance.Id; 
            wrapperInstance.status = 'Success';
        }
        catch(DmlException e) {
            wrapperInstance.isSuccess = false; 
            wrapperInstance.leadId = ''; 
            wrapperInstance.status = e.getMessage();
        } 
        return wrapperInstance;
    }
     // HttpDelete is used to insert a lead record
     // Deleting a lead record 
    @HttpDelete 
    global static RestWrapLeadInformation deleteLead() {
        RestRequest getParameter = RestContext.request;
        String strDeleteFirstName = getParameter.params.get('FirstName');
        String strDeleteLastName = getParameter.params.get('LastName');
        String strDeleteCompany = getParameter.params.get('Company');
        String strDeleteStatus = getParameter.params.get('Status');
        String stremailDelete = getParameter.params.get('Email');
        String phoneDelete = getParameter.params.get('Phone');
        
        List<Lead> leadListDelete = [SELECT  Id FROM Lead  WHERE FirstName = :fNameDelete];
        RestWrapLeadInformation wrapperInstance = new RestWrapLeadInformation();
        try { 
            delete leadListDelete[0];
            wrapperInstance.isSuccess = true; 
            wrapperInstance.leadId = leadListDelete[0].Id; 
            wrapperInstance.status = 'Success';
        }
        catch(DmlException e) {
            wrapperInstance.isSuccess = false; 
            wrapperInstance.leadId = ''; 
            wrapperInstance.status = e.getMessage();
        } 
        return wrapperInstance;
    }
    //HttpPatch is used to update a lead record
    // Updating a lead record
    @HttpPatch
    global static RestWrapLeadInformation leadUpdate(
        String firstNameUpdate,
        String phoneUpdate) {
        RestRequest getParameter = RestContext.request;
        String firstNameUpdat = getParameter.params.get('FirstName');
        List<Lead> leadListUpdate = new List<Lead>();
        leadListUpdate = [SELECT Id,FirstName  FROM Lead WHERE FirstName = :firstNameUpdate];
         
        RestWrapLeadInformation wrapperInstance = new RestWrapLeadInformation();
        leadListUpdate[0].Phone = getParameter.params.get('Phone');
        try {
            update leadListUpdate[0];
            wrapperInstance.isSuccess = true; 
            wrapperInstance.leadId = leadListUpdate[0].Id; 
            wrapperInstance.status = 'Success';
        } catch(DmlException e) {
            wrapperInstance.isSuccess = false; 
            wrapperInstance.leadId = ''; 
            wrapperInstance.status = e.getMessage();
        } 
        return wrapperInstance;
    }
    // Wrapper class to display fields after DML operations
    global class RestWrapLeadInformation {
        public Boolean isSuccess;
        public String leadId;
        public String status;
         
     // Initializating the variables
         public RestWrapLeadInformation() {
            isSuccess = false;
            leadId = '';
            status = '';
         }