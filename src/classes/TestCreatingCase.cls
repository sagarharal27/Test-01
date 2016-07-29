/************************************************************************
 Class Name: TestCreatingCase
 Created Date:2/8/2015
 Description: This test class performs test on EFT transaction
*************************************************************************/  
@isTest
@testVisible
public class TestCreatingCase {
    //List of EFT_Transaction_Status__c
    static List<EFT_Transaction_Status__c> eftListTest = new List<EFT_Transaction_Status__c>();
    //List of SalesHeader__c
    static List<SalesHeader__c> salesHeaderList = new List<SalesHeader__c>();
    
    //Inintializing counter to count case 
    static Integer counterCasesBefore=0;
    static Integer counterCasesAfter=0; 
    
    //Test method 1:creating case with valid salesHeader status and valid EFT values
    public static testMethod void creatingValidCase() {
        //getting data from TestDatafactory 
        salesHeaderList = TestDatafactory.salesHeaderValidData(30); 
                
        insert salesHeaderList; 
        System.debug('salesHeaderList::'+salesHeaderList);
        
        counterCasesBefore = [select id from case ].size();
                
        salesHeaderList = [select Id from SalesHeader__c ];
                
        test.StartTest();
            eftListTest = TestDatafactory.EFTValidData(salesHeaderList,30);
            insert eftListTest;
            counterCasesAfter = [select id from Case].size();
            System.debug('eftListTest:::'+eftListTest);
        test.StopTest();
       
        System.assertNotEquals(counterCasesBefore,counterCasesAfter);
    }
    //Test method 2:creating case with valid salesHeader status and Invalid EFT method name
     public static testMethod void creatingInValidCase1() {
        //getting data from TestDatafactory 
        salesHeaderList = TestDatafactory.salesHeaderValidData(30);
                
        insert salesHeaderList; 
        System.debug('salesHeaderList::'+salesHeaderList);
        counterCasesBefore = [select id from case ].size();
        salesHeaderList = [select Id from SalesHeader__c ];
                
        test.StartTest();
            eftListTest = TestDatafactory.EFTDataWithInvalidMethodName(salesHeaderList,30);
            insert eftListTest;
            counterCasesAfter = [select id from Case].size();
            System.debug('eftListTest:::'+eftListTest);
        test.StopTest();
               
        System.assertEquals(counterCasesBefore,counterCasesAfter);
    }
    //Test method 3:creating case with valid salesHeader values and Invalid EFT Status
    public static testMethod void creatingInValidCase2() {
        //getting data from TestDatafactory 
        salesHeaderList = TestDatafactory.salesHeaderValidData(30);
                
        insert salesHeaderList; 
        System.debug('salesHeaderList::'+salesHeaderList);
        counterCasesBefore = [select id from case ].size();
        System.debug('counterCasesBefore:::'+counterCasesBefore);
        salesHeaderList = [select Id from SalesHeader__c ];
                
        test.StartTest();
            eftListTest = TestDatafactory.EFTDataWithInvalidStatus(salesHeaderList,30);
            insert eftListTest;
            counterCasesAfter = [select id from Case].size();
            System.debug('eftListTest:::'+eftListTest);
        test.StopTest();
               
        System.assertEquals(counterCasesBefore,counterCasesAfter);
    }
    //Test method 4:creating case with Invalid salesHeader status and valid EFT values
    public static testMethod void creatingInValidCase3() {
        //getting data from TestDatafactory 
        salesHeaderList = TestDatafactory.salesHeaderInvalidData(30);
                
        insert salesHeaderList; 
        System.debug('salesHeaderList::'+salesHeaderList);
        counterCasesBefore = [select id from case ].size();
        System.debug('counterCasesBefore:::'+counterCasesBefore);
        salesHeaderList = [select Id from SalesHeader__c ];
                
        test.StartTest();
            eftListTest = TestDatafactory.EFTValidData(salesHeaderList,30);
            insert eftListTest;
            counterCasesAfter = [select id from Case].size();
            System.debug('eftListTest:::'+eftListTest);
        test.StopTest();
        
        System.assertEquals(counterCasesBefore,counterCasesAfter);
    }
    //Test method 5:creating case with Invalid salesHeader values and Invalid EFT method name
    public static testMethod void creatingInValidCase4() {
        //getting data from TestDatafactory 
        salesHeaderList = TestDatafactory.salesHeaderInvalidData(30);
                
        insert salesHeaderList; 
        System.debug('salesHeaderList::'+salesHeaderList);
        counterCasesBefore = [select id from case ].size();
        System.debug('counterCasesBefore:::'+counterCasesBefore);
        salesHeaderList = [select Id from SalesHeader__c ];
                
        test.StartTest();
            eftListTest = TestDatafactory.EFTDataWithInvalidMethodName(salesHeaderList,30);
            insert eftListTest;
            counterCasesAfter = [select id from Case].size();
            System.debug('eftListTest:::'+eftListTest);
        test.StopTest();
        
        System.assertEquals(counterCasesBefore,counterCasesAfter);
    }
    //Test method 6:creating case with Invalid salesHeader values and Invalid EFT status
     public static testMethod void creatingInValidCase5() {
        //getting data from TestDatafactory 
        salesHeaderList = TestDatafactory.salesHeaderInvalidData(30);
                
        insert salesHeaderList; 
        System.debug('salesHeaderList::'+salesHeaderList);
        counterCasesBefore = [select id from case ].size();
        System.debug('counterCasesBefore:::'+counterCasesBefore);
        salesHeaderList = [select Id from SalesHeader__c ];
                
        test.StartTest();
            eftListTest = TestDatafactory.EFTDataWithInvalidStatus(salesHeaderList,30);
            insert eftListTest;
            counterCasesAfter = [select id from Case].size();
            System.debug('eftListTest:::'+eftListTest);
        test.StopTest();
        
        System.assertEquals(counterCasesBefore,counterCasesAfter);
    }
}