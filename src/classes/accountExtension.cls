public with sharing class accountExtension {
    ApexPages.StandardController sc;
    public accountExtension(ApexPages.StandardController sc) {
        this.sc = sc;
    }
    
    public void customeSave() {
        if(account.Email_ID__c == NULL ) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error Message.'));
        }
        else{ 
            sc.save(); 
        }
    }
    public PageReference customCancel() {
        sc.cancel();
        PageReference accountPage =Page.showAccountList;
        return accountPage;
    }
}