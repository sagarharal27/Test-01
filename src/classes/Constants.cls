public with sharing class Constants {
    public static final string strAccountIndustry = 'Media';
    public static final string strMethodNameEFT = 'Credit Card Address Verify';
    public static final string strTransactionStatusEFT = 'Declined';
    public static final string strStatusSalesHeader = 'Open';
    public static final string strOriginCase = 'Internal';
    public static final string strReasonCase = 'Address Did Not Verify';
    public static final string strPriorityCase = 'High';
    public static final string strStatusCase = 'New';
    public static final string strSubjectNameCase = 'Pooja';
<<<<<<< HEAD
    
    public static final string strStudentLanguageEng= 'English';
    public static final string strStudentLanguageFre= 'French';
    public static final string strStudentLanguageSpa= 'Spanish';
        
    public static final string strStudentLanguageCodeEng= 'en_US';
    public static final string strStudentLanguageCodeFre= 'fr';
    public static final string strStudentLanguageCodeSpa= 'es';
    
    public static final string strClosedOpp = 'SELECT o.Name,o.Amount,o.Account.Primary_Contact__c FROM Opportunity o WHERE o.StageName = \'Closed Won\' AND CreatedDate = TODAY';
    public static final string strEmailSubject ='Aggregate Of total Amount';
    public static final string strEmailGreet = ' Dear Account : ';
    public static final string strEmailOppName = 'The Amount for Opportunity name';
    public static final string strEmailAmount = ' is equals to ';
    public static final string strEmailAggregate =' And the total Aggregate Amount is';
=======
    public static final string strStudentLanguageEng= 'English';
    public static final string strStudentLanguageFre= 'French';
    public static final string strStudentLanguageSpa= 'Spanish';
    
    public static final string strClosedOpp= 'SELECT o.Name,o.Amount,o.Account.Primary_Contact__c FROM Opportunity o WHERE o.StageName = \'Closed Won\'';
    public static final string strEmailSubject='Aggregate Of total Amount';
    public static final string strEmailGreet= ' Dear Account : ';
    public static final string strEmailOppName= 'The Amount for Opportunity name';
    public static final string strEmailAmount= ' is equals to ';
    public static final string strEmailAggregate=' And the total Aggregate Amount is';
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
}