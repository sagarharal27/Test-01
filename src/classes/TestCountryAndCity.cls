/************************************************************************
 Class Name: TestCountryAndCity
 Created Date:2/8/2015
 Description: This test class test DependentlistOfCity
*************************************************************************/  
@isTest
private class TestCountryAndCity {
    
<<<<<<< HEAD
    static List<CustomCity__c> listCustomCity = new List<CustomCity__c>();
    static testMethod void initialTest() {
        List<selectoption> checkList  = new List<selectoption>();
        CustomCity__c  instance = new CustomCity__c();
        instance.Name = 'India';
        instance.City__c = 'Pune';
        insert instance;  
        
        DependentListController controllerObj = new DependentListController();
        //List<SelectOption> listSelectOption = new List<SelectOption>();
        checkList = controllerObj.getCityList();
        System.assertEquals(1,checkList.size());
    }
    static testMethod void initialTest1() {
        List<selectoption> checkList  = new List<selectoption>();
        CustomCity__c  instance = new CustomCity__c();
        for(integer i = 0 ; i < 2; i++) {
            instance.Name = 'India'+i;
        }  
        insert instance;  
        DependentListController controllerObj = new DependentListController();
        //List<SelectOption> listSelectOption = new List<SelectOption>();
        checkList = controllerObj.getCountrylist();
        System.assertEquals(2,checkList.size());
    } 
}
   
=======
    static List<Country__c> countryList = new List<Country__c>();
    static List<City__c> cityList = new List<City__c>();
    //method to check country
    static testMethod void testForCountryOption() {
       
        countryList=TestDatafactory.countryData(3);
        insert countryList;
        
        DependentListController controller = new DependentListController();
        List<SelectOption> optionList = new List<SelectOption>();
        optionList = controller.selectedCountry();
        system.debug('*************11*************');
        System.assertEquals(3,optionList.size()); 
     }
    //method to ckeck related city of country
    public static testmethod void testForCityOption() {
        
        countryList=TestDatafactory.countryData(3);
        cityList=TestDatafactory.cityData(3);
        
        Test.startTest();
            insert countryList;
            insert cityList;
        Test.stopTest();
        
        DependentListController controller = new DependentListController();
        controller.strRelatedCity = 'India';
        List<SelectOption> optionList = new List<SelectOption>();
        controller.relatedCity();
        System.assertEquals(3,controller.listOfCity.size()); 
      }
} 
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
