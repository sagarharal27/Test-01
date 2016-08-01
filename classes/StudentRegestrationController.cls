/**
 * Create a VF Page .This page should display a student registration form. And a submit button. 
 * On click of submit button student record should get created with details provided by the user, 
 * and a success message (“Your admission application has been submitted successfully”) 
 * should be displayed on the page.
 * At the top of this visualforce page there should be a picklist to select language. 
 * The Language picklist should have 3 options: English, French and Spanish.
 * The page should display content in the language selected by the user.
 */
public with sharing class StudentRegestrationController {
    public Student__c studentInstance {get; set;}
    public String languageOption {get; set;}
    public List<SelectOption> allLanguage;
    List<SelectOption> listLanguageInstance = new List<SelectOption>();
    
    /**
     * Creating an instance of Student__c in constructor
     */
    public StudentRegestrationController(ApexPages.StandardController StandardControllerExtension) {
        studentInstance = (Student__c) StandardControllerExtension.getRecord();
    }
    
    /**
     * Get all the languages to picklist
     */ 
    public List<SelectOption> getallLanguage() {
        listLanguageInstance.add(new SelectOption('', '--Select Language--'));
        
        // Get the languages from the custom settings object
        for (Language__c languageInstance : Language__c.getAll().Values()) {
            listLanguageInstance.add(new SelectOption(
                languageInstance.Code__c, languageInstance.Name));
        }
        return listLanguageInstance;
    }
    
    /**
     * Inserting the record by the saveRecord()
     */
    public PageReference saveRecord() {
        
        // Check if the studentInstance is not null
        if (studentInstance != null) {
            insert studentInstance;
            
            // Display the message 'successful submission of application' which is stored in label
            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.INFO, 
                System.Label.Message
            ));
        }
        studentInstance.clear();
        return null;
    }
}