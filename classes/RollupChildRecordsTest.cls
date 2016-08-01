/**
 *
 */
@isTest
private class RollupChildRecordsTest {

    /**
     *
     */
    static testMethod void testInsert() {

        Parent__c parentObj = new Parent__c(Name = 'Parent 1'); 
        insert parentObj;

        // Verify the insert 
        System.assertNotEquals(null, parentObj.Id);

        Child__c childObj = new Child__c(Name = 'Child 1', Amount__c = 100, ParentId__c = parentObj.Id);

        Test.startTest();
        insert childObj;
        Test.stopTest();

        List<Parent__c> parentList = [SELECT Id
                                           , Total_Childs__c
                                           , Total_Amount__c
                                        FROM Parent__c
                                       WHERE Id = :parentObj.Id
                                       LIMIT 1
        ];

        // Verify the result 
        System.assertEquals(100, parentList[0].Total_Amount__c);
        System.assertEquals(1, parentList[0].Total_Childs__c);

    }

    /**
     * 
     */
    static testMethod void testUpdate() {

        Parent__c parentObj = new Parent__c(Name = 'Parent 1'); 
        insert parentObj;

        // Verify the insert 
        System.assertNotEquals(null, parentObj.Id);

        Child__c childObj = new Child__c(Name = 'Child 1', Amount__c = 100, ParentId__c = parentObj.Id);
        insert childObj;

        // Verify the insert 
        System.assertNotEquals(null, childObj.Id);

        Test.startTest();
        childObj.Amount__c = 200; 
        update childObj;
        Test.stopTest();

        List<Parent__c> parentList = [SELECT Id
                                           , Total_Childs__c
                                           , Total_Amount__c
                                        FROM Parent__c
                                       WHERE Id = :parentObj.Id
                                       LIMIT 1
        ];

        // Verify the result 
        System.assertEquals(200, parentList[0].Total_Amount__c);
        System.assertEquals(1, parentList[0].Total_Childs__c);

    }

    /**
     * 
     */
    static testMethod void testDelete() {

        Parent__c parentObj = new Parent__c(Name = 'Parent 1'); 
        insert parentObj;

        // Verify the insert 
        System.assertNotEquals(null, parentObj.Id);

        Child__c childObj = new Child__c(Name = 'Child 1', Amount__c = 100, ParentId__c = parentObj.Id);
        insert childObj;

        // Verify the insert 
        System.assertNotEquals(null, childObj.Id);

        Test.startTest();
        delete childObj;
        Test.stopTest();

        List<Child__c> childList = [SELECT Id
                                      FROM Child__c
                                     WHERE Id = :childObj.Id
                                     LIMIT 1
        ];
        System.assertEquals(true, childList.isEmpty());

        List<Parent__c> parentList = [SELECT Id
                                           , Total_Childs__c
                                           , Total_Amount__c
                                        FROM Parent__c
                                       WHERE Id = :parentObj.Id
                                       LIMIT 1
        ];

        // Verify the result 
        //System.assertEquals(0, parentList[0].Total_Amount__c);
        System.assertEquals(0, parentList[0].Total_Childs__c);

    }

/*
    static testMethod void testUndelete() {

        Parent__c parentObj = new Parent__c(Name = 'Parent 1'); 
        insert parentObj;

        // Verify the insert 
        System.assertNotEquals(null, parentObj.Id);

        Child__c childObj = new Child__c(Name = 'Child 1', Amount__c = 100, ParentId__c = parentObj.Id);
        insert childObj;

        // Verify the result 
        System.assertEquals(100, parentObj.Total_Amount__c);
        System.assertEquals(1, parentObj.Total_Childs__c);

        delete childObj;

        // Verify the result 
        System.assertEquals(null, parentObj.Total_Amount__c);
        System.assertEquals(null, parentObj.Total_Childs__c);

        Test.startTest();
        undelete childObj;
        Test.stopTest();

        // Verify the result 
        System.assertEquals(100, parentObj.Total_Amount__c);
        System.assertEquals(1, parentObj.Total_Childs__c);
    }
*/
}