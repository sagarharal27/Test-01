/**
 * Controller class to get the field from the page 
 * on which the deletion has to be performed
 */
public with sharing class BatchLeadsController {
    public String selectedField {get; set;}
    public List<SelectOption> leadFields {get; set;}
    
    /**
     * Configurable fields list 
     */
    public List<SelectOption> getConfigurableFields() {
        List<SelectOption> leadFields = new List<SelectOption>();
        leadFields.add(new SelectOption('None', 'None'));
        leadFields.add(new SelectOption('Name', System.Label.Name));
        leadFields.add(new SelectOption('Email', System.Label.Email));
        leadFields.add(new SelectOption('Phone', System.Label.Phone));
        return leadFields;
    }
    
    /**
     * Update the field in the custom settings
     */
    public void updateField() {
        if (selectedField != 'None') {
            DuplicateLeads__c duplicateLeadInstance = [ 
                SELECT 
                    Name 
                FROM 
                    DuplicateLeads__c 
                WHERE 
                    Name <> null
            ];
            duplicateLeadInstance.Name = selectedField;
            update duplicateLeadInstance;
        } else {
            System.debug('Helppp !!');
        }
    }
}