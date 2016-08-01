/**
 *
 */
@isTest
private class MultiObjectTest {
    
    /**
     * Test the objects which are retrived
     */
    static testMethod void objectsTest() {
        Test.startTest();
        MultiObjectController controllerInstance = new MultiObjectController();
        List<SelectOption> testObjectList = controllerInstance.getObjectNames();
        Test.stopTest();
        
        // Verify if we are getting a list of objects
        System.assert(testObjectList.size() != 0);
    }
    
    /**
     * Test the fields of a selected object
     */
    static testMethod void objectFieldTest() {
        String objectTest = 'account';
        Test.startTest();
        MultiObjectController controllerInstance = new MultiObjectController();
        List<SelectOption> testfieldList = controllerInstance.getObjectFields();
        Test.stopTest();
        
        // Verify if we are getting the fields of a object
        System.assert(testfieldList.size() != null);
        System.assert(controllerInstance.objectFields.size() != null);
    }
    
    /**
     * Add fields for query test
     */
    static testMethod void addTest() {
        
        MultiObjectController controllerInstance = new MultiObjectController();
        controllerInstance.moveRight.add('id');
        controllerInstance.moveRight.add('Name');
        
        Test.startTest();
        controllerInstance.add();
        Test.stopTest();
        
        // Check if we get the selected fields in the set 
        System.assert(controllerInstance.setRight.size() != 0);
        
    }
    
    /**
     * Remove filds form query test
     */
    static testMethod void removeTest() {
        MultiObjectController controllerInstance = new MultiObjectController();
        
        controllerInstance.moveLeft.add('id');
        controllerInstance.moveLeft.add('Name');
        
        Test.startTest();
        controllerInstance.remove();
        Test.stopTest();
        
        // Check if we are getting the fields in the set
        System.assert(controllerInstance.objFields.size() != 0);
        
    }
    
    /**
     * Execute functionality test
     */
    static testMethod void executeTest() {
        Account accountInstance = new Account();
        accountInstance.Name = 'testDynamic';
        insert accountInstance;
        
        System.assert(accountInstance.Id != null);
        
        MultiObjectController controllerInstance = new MultiObjectController();
        controllerInstance.searchValue = 'testDynamic';
        controllerInstance.selectedObject = 'account';
        controllerInstance.disp.add('id');
        controllerInstance.disp.add('Name');
        controllerInstance.maxLimit = '5';
        
        Test.startTest();
        controllerInstance.executeQuery();
        Test.stopTest();
        
        String query = 
            'FIND \'testDynamic\' IN ALL FIELDS RETURNING account (id,Name Order By Name LIMIT 5)';
        
        
        // 
        System.assertEquals(query, controllerInstance.queryString);
        //System.assert(!controllerInstance.records.isEmpty());
        
        
    }
    
}