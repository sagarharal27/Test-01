@isTest
private class TestDynamicSOQLStatement {
    
    // Method to test the fields selected
    static testMethod void initialPage() {
        DynamicSOQLStatements contollerInstance = new DynamicSOQLStatements();
        contollerInstance.selectObject = 'Account';
        Integer sizeOffieldList = Schema.getGlobalDescribe().get(contollerInstance.selectObject).getDescribe().fields.getMap().keyset().size();
        Integer fieldsListSize;
         
        Test.startTest();
            contollerInstance.getFieldList();
            fieldsListSize = contollerInstance.fieldSet.size();
        Test.stopTest();
        system.assertEquals(sizeOffieldList, fieldsListSize);
    }
    static testMethod void testQueryExecution() {
        DynamicSOQLStatements contollerInstance = new DynamicSOQLStatements();
        List<Account> accountTestList = new List<Account>();
        for(Integer i = 0; i < 5; i++) {
            Account accountInstance = new Account(Name = 'testAccount'+i,
                                         Email_ID__c = i+'test'+i+'@account.com',
                                         WebSite = 'http://www.webaccount.com');
            accountTestList.add(accountInstance);   
        }
        insert accountTestList;
        contollerInstance.selectObject = 'Account';
        contollerInstance.selectedField.add('Name');
        contollerInstance.selectedField.add('Id');
        contollerInstance.orderOfOptions = 'ASC';
        contollerInstance.showSelectedFieldList();
        contollerInstance.queryList = 'test';
        
        String queryList = 'FIND {test}  IN ALL FIELDS RETURNING  Account ( Name , Id  ORDER BY Name ASC ) LIMIT 500';
        List<List<Sobject>> testResult = Search.Query(queryList);
        Test.startTest();
            contollerInstance.executeQuery();
        Test.stopTest();
        system.assertEquals(testResult.size(), contollerInstance.dynamicRecordsList.size());
    }
    static testMethod void testFieldsSelection() {
        PageReference pageref = page.DynamicSOQLStatements;
        Test.setCurrentPage(pageRef);
        DynamicSOQLStatements contollerInstance = new DynamicSOQLStatements();
        contollerInstance.selectObject='Account'; 
        contollerInstance.selectedField.add('Name');
        contollerInstance.selectedField.add('Id');
        contollerInstance.selectedField.add('Email_ID__c');
        contollerInstance.showselectedFieldList();
        system.assertEquals(3,contollerInstance.selectedFieldList.size());
    }
    
}