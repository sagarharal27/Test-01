/************************************************************************
 Class Name: StudentRegistrationExtension
 Created Date:8/8/2015
 Description: This test class contains data for objects to be tested
*************************************************************************/  

public with sharing class StudentRegistrationExtension {
    
    public Student__c studentInstance{get; set;}
    public String languageOption{get; set;}
    
    public List<SelectOption> languageList;
        
<<<<<<< HEAD
    //Creating an instance in constructor
    public StudentRegistrationExtension(ApexPages.StandardController StandardControllerExtension) {
            studentInstance = (Student__c)StandardControllerExtension.getRecord();
=======
    // Creating an instance in constructor
    public StudentRegistrationExtension(ApexPages.StandardController StandardControllerExtension) {
        studentInstance = (Student__c)StandardControllerExtension.getRecord();
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
    }
    
    //Method to Save record
    public PageReference saveRecord() {
        if(studentInstance.Student_Name__c <> Null) {
            insert studentInstance; 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,
                                System.Label.MessageForRegistration));
                                
        }
        else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,
                                System.Label.ErrorMessageForRegistration));
        }
        studentInstance.clear();
        return Null;
    }
    // Add the languages to the picklist     
    public List<SelectOption> getlanguageList() {
        List<SelectOption> listLanguageInstance = new List<SelectOption>();
<<<<<<< HEAD
        listLanguageInstance.add(new SelectOption(Constants.strStudentLanguageCodeEng,
                                                    Constants.strStudentLanguageEng));
        listLanguageInstance.add(new SelectOption(Constants.strStudentLanguageCodeFre,
                                                    Constants.strStudentLanguageFre));
        listLanguageInstance.add(new SelectOption(Constants.strStudentLanguageCodeSpa,
                                                    Constants.strStudentLanguageSpa));
        if(!listLanguageInstance.isEmpty()) {
            return listLanguageInstance;
        }
        else {
            System.debug('No records...');
            return null;
        }
=======
        listLanguageInstance.add(new SelectOption('en_US',Constants.strStudentLanguageEng));
        listLanguageInstance.add(new SelectOption('fr',Constants.strStudentLanguageFre));
        listLanguageInstance.add(new SelectOption('es',Constants.strStudentLanguageSpa));
        return listLanguageInstance;
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
    }
}