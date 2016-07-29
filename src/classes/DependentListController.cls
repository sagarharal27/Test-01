/***************************************************************************************************
 Class Name: DependentListController
 Created Date:2/8/2015
 Description: This controller is used to display Cities of respective countries in VF page
***************************************************************************************************/  

public with sharing class DependentListController {
<<<<<<< HEAD
    
    public String City{ get; set; }
    public String country{ get; set;}
    
    //Map of String(Country) and respective cities 
    Map<String, CustomCity__c> mapOfCity = CustomCity__c.getall();
    
    //Method to get list of city
    public List<selectoption> getCityList() {
        //List of collection of selected items
        List<selectOption> selectList = new List<selectOption> ();
        selectList.add(new selectoption('','---None---'));
        //Null check for country 
        if(country==null){
            country='';
        }
        else
            //Checking for country in map,if country is present
            if(mapOfCity.containskey(country)) {
                //clear the selectList
                selectList.clear();
                //Get all the cities related to that country
                string strCityOfCountry = mapOfCity.get(country).City__c;
                //Getting the list of cities separated by , 
                for(string strCity : strCityOfCountry.split(','))
                    //Add those cities to the list
                    selectList.add(new selectoption(strCity,strCity));
            }
        //null check for list    
        if(!selectList.isEmpty()) {
            return selectList;
        }
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info,
                                        System.Label.ErrorrForNoRecords));
            return null;
        }
    }

    // Method to get country
    public List<SelectOption> getCountrylist() {
        //List of collection of selected items
        List<SelectOption> countryList = new List<SelectOption>();
        countryList.add(new selectoption('','---None---'));
        
        // Creating List of country name 
        List<string> countryname= new List<string>(); 
        //adding all cities to the country 
        countryname.addall(mapOfCity.keyset());
        
        //Iterate to list of country for country
        for(string strCountry : countryname){
            //Adding that country to the list
            countryList.add(new selectoption(strCountry,strCountry));
        }
        //null check for List     
        if(!countryList.isEmpty()) {
            return countryList;    
        }
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info,
                                        System.Label.ErrorrForNoRecords));
            return null;
        }    
    }
=======
    public String strCounty{get;set;}
    public List<SelectOption> listOfCountry{get;set;}
    
    public String strRelatedCity{get;set;}
    public List<selectOption> listOfCity{get;set;}
    
    //constructor
    public DependentListController() {
        selectedCountry();
    }
    //Method for related city of country
    public List<SelectOption> selectedCountry() {
        listOfCountry = new List<SelectOption>();
        for (Country__c countryInstance : Country__c.getAll().Values()) {
            listOfCountry.add(new SelectOption(countryInstance.Name,countryInstance.Name));
        }
        return listOfCountry;
    }
    //Method for related city of country
    public void relatedCity() { 
        listOfCity = new List<SelectOption>();
        //listOfCity.add(new SelectOption(' ', '--None--'));
        for (City__c cityInstance :City__c.getAll().Values()) {
            listOfCity.add(new SelectOption(cityInstance.Name,cityInstance.Name));
        } 
    } 

>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
}