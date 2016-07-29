/***************************************************************************************************
Class : SOAPServiceOfLead
Created Date : 19/8/2015
Description : This is webService provided to create ,delete and update the lead from another org
***************************************************************************************************/
global with sharing class SOAPServiceOfLead {
    
    //web service method to create lead
    webService static String createNewLead (String strFirstName, String strLastname,
                                            String strStatus, String strCompany,
                                            String strEmail, String strPhone) {
        
        String showMessage;
        //Creating fields of lead
        Lead leadObj = new Lead();
        leadObj.LastName = strLastname;
        leadObj.FirstName = strFirstName;
        leadObj.Status = strStatus;
        leadObj.Company = strCompany;
        leadObj.Email = strEmail;
        leadObj.MobilePhone = strPhone;
        
        try{
            //Inserting lead record 
            Database.SaveResult results = Database.insert(leadObj); 
            if (results.isSuccess()){  
                //If lead inserted successfully,get the ID of the record that was processed
                showMessage= 'isSuccess = True . Lead ID: ' + results.getId() + 'status = Success';
            }
        }
        //Handling exception while inserting lead
        catch(DmlException e){
            showMessage='isSuccess = False .Required field is missing ' +'Lead ID: NULL' + 'status = Failure';
        }
        //Displaying message
        return showMessage;
    }
    
    //Method to delete the lead record 
    webService static string deleteLead(String strFirstName, String strLastname, String strEmail,String strPhone){
        string showMessage;
        //Retriving records having same FirstName
        List<Lead> leadList=[Select Id From Lead Where FirstName = :strFirstName AND
                                                       LastName = :strLastname AND
                                                       Email = :strEmail AND
                                                       MobilePhone = :strPhone];
        try{
            //If record exists,delete the record
            if (leadList.size() > 0) {
                Database.DeleteResult deleteResult = Database.delete(leadList[0],false);
                
                if (deleteResult.isSuccess()){
                    showMessage= 'isSuccess = True .  ' + 'Deleted lead is :'+ strFirstName +'status= Success';
                }
            }
        }
        //If record is not deleted ,show the message
        catch(DmlException e){
            showMessage= 'isSuccess = False . Lead deleted =  ' +'status=Failure ';
        }
        return showMessage;
    }
    // Method to update the lead record
    webService static string updateLead(String strFirstName,String strLastname,String strEmail,String strPhone){
        string showMessage; 
        // Retriving the list form the lead to update      
        List<Lead> leadList = new List<Lead> ([SELECT FirstName,Id
                                              FROM Lead
                                              WHERE FirstName = :strFirstName
                                              AND LastName = :strLastname]);
        try{
            // If lead is not empty 
            if(!leadList.isEmpty()) {
                leadList[0].Phone = strPhone;
                leadList[0].Email = strEmail;
                // Update the list 
                Database.SaveResult saveResult = Database.update(leadList[0],false);
         
                if(saveResult.isSuccess()){
                    showMessage= 'isSuccess=True .' + 'Record updated successfully'+ strFirstName +'status= Success';
                }
            }
        }
        //If record is not updated show an error
        catch(DmlException e) {
            showMessage= 'isSuccess = False.Update fail ' +'status=Failure ';
        }
        return showMessage;
    }
}