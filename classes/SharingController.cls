public without sharing class SharingController {
    List<Employee__c> empLists;
    public list<Employee__c> getempList() {
            empLists = [SELECT e.Name, e.First_Name__c FROM Employee__c e];
            return empLists;
    }
}