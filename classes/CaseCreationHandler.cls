/**
 * Trigger for Updating Cases that come in from the Web, Email or Chat
 * Use Case – we would like to use the email address of the incoming case to see 
 * if we can associate the correct person account to populate the Account and Contact Fields.
 * When a new case is created and the Case.Origin field is set to 
 * “Chat” or “Email” or “Web” take the Case.
 * SuppliedEmail field and look up to find a match in the following account fields 
 * Account.PersonEmail, Account.Email_Address__c
 */
public with sharing class CaseCreationHandler {
    
    /**
     * Getting the case record and updating the case lookup fields
     */
    public CaseCreationHandler(List<Case> caseParameter ) {
        Map<String, Id> accountEmailMap = new Map<String, Id>();
        Map<String, Id> contactEmailMap = new Map<String, Id>();
        
        // Get the fields of account and contact from contact object 
        List<Contact> contactsList = [
            SELECT 
                Id, 
                AccountId, 
                Account.Email_Address__c, 
                Account.Person_Email__c
            FROM 
                Contact
        ];
        
        // Add the email id in the key part and the id of that email in the value part
        for (Contact contactInstance : contactsList) {
            
            // For Account Email id
            if (contactInstance.Account.Email_Address__c != null) {
                
                // Email address
                accountEmailMap.put(
                    contactInstance.Account.Email_Address__c, 
                    contactInstance.AccountId
                );
            } else {
                
                // Person email address
                accountEmailMap.put(
                    contactInstance.Account.Person_Email__c, 
                    contactInstance.AccountId
                );
            }
            
            // For contact Email id
            if (contactInstance.Email != null) {
                contactEmailMap.put(
                    contactInstance.Email, 
                    contactInstance.Id
                );
            }
        }
        
        
        for (Case caseObject : caseParameter) {
            
            // Check if origin field on case object consist of chat or email or web  
            if (caseObject.Origin == 'Chat' 
                || caseObject.Origin == 'Web' 
                || caseObject.Origin == 'Email' 
            ) {
                
                // Update account lookup field on case
                if (accountEmailMap.containsKey(caseObject.SuppliedEmail)) {
                    caseObject.AccountId = accountEmailMap.get(caseObject.SuppliedEmail) ;
                }
                
                // Update contact lookup field on case
                if (contactEmailMap.containsKey(caseObject.SuppliedEmail)) {
                    caseObject.ContactId = contactEmailMap.get(caseObject.SuppliedEmail) ;
                }
            }
        }
    }
}