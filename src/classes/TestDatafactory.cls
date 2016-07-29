/************************************************************************
 Class Name: TestDataFactory
 Created Date:2/8/2015
 Description: This test class contains data for objects to be tested
*************************************************************************/  
@isTest
public class TestDatafactory { 
//***********************DATA FOR CONTACT***********************************************************
    //creating data for Contact 
    public static list<Contact> contactData(Integer num) { 
       List<Contact> lstcon=new List<Contact>();
       for (integer i = 0; i < num; i++) {
           Contact con=new Contact(Email='test@gmail.com'+i, Phone='123'+i, LastName = 'Test'+i);
           lstcon.add(con);
        }
        return lstcon;
    }
    //creating data for contact with different Email
    public static list<Contact> contactData2(Integer num) { 
       List<Contact> lstcon=new List<Contact>();
       for (integer i = 0; i < num; i++) {
           Contact con=new Contact(Email='test@yahoo.com'+i, Phone='123'+i, LastName = 'Test'+i);
           lstcon.add(con);
        }
        return lstcon; 
    }
    
    //**************************DATA FOR ACCOUNT********************************************************
    //creating data for Account
    public static List<Account> accountData(Integer num){
    List<Account> accList= new List<Account>();
    for (integer i = 0; i < num; i++) {
           Account accInstance=new Account(Name='test'+i,Website = 'www.gmail.com'+i);
           accList.add(accInstance);
        } 
        return accList;
    }
//*************************DATA FOR SALESHEADER*****************************************************
   //Crating data for salesHeader EFT_Transaction_Status with valid values
    public static list<SalesHeader__c> salesHeaderValidData(Integer num) {
        List<SalesHeader__c> salesHeaderList = new List<SalesHeader__c>();
        SalesHeader__c salesInstance;
        for(integer i = 0; i < num; i++) {
            salesInstance = new SalesHeader__c(Name='Sales'+i,Status__c='Open');
            salesHeaderList.add(salesInstance);
         }
         system.debug('salesHeaderList+++++++++++'+salesHeaderList);
         return salesHeaderList;
    }
    //Crating data for salesHeader EFT_Transaction_Status with Invalid values
    public static list<SalesHeader__c> salesHeaderInvalidData(Integer num) {
        List<SalesHeader__c> salesHeaderList = new List<SalesHeader__c>();
        SalesHeader__c salesInstance;
        for(integer i = 0; i < num; i++) {
            salesInstance = new SalesHeader__c(Name='Sales'+i,Status__c='Close');
            salesHeaderList.add(salesInstance);
         }
         system.debug('salesHeaderList+++++++++++'+salesHeaderList);
         return salesHeaderList;
         
    }
//*************************DATA FOR EFT_Transaction_Status******************************************
    //Crating valid data for EFT_Transaction_Status
    public static list<EFT_Transaction_Status__c> EFTValidData(List<SalesHeader__c> salesHeaderList,
                                                                 Integer num) {
        
        List<EFT_Transaction_Status__c> EFTList = new List<EFT_Transaction_Status__c>();
        for (integer i=0; i < num; i++) {
            EFT_Transaction_Status__c EFTObj = new EFT_Transaction_Status__c(Name='TestEFT', 
                                                   Method_Name__c='Credit Card Address Verify',
                                                   Transaction_Status__c='Declined',
                                                   SalesLookup__c = salesHeaderList[i].Id);
            EFTlist.add(EFTObj);
         }
         system.debug('EFTlist:::::::::::::::::::::::'+EFTlist);
         return EFTList;
    }
     //Crating Invalid Method name data for EFT_Transaction_Status
    public static list<EFT_Transaction_Status__c> EFTDataWithInvalidMethodName(List<SalesHeader__c>
                                                     salesHeaderList,Integer num) {
        
        List<EFT_Transaction_Status__c> EFTList = new List<EFT_Transaction_Status__c>();
        for (integer i=0; i < num; i++) {
            EFT_Transaction_Status__c EFTObj = new EFT_Transaction_Status__c(Name='TestEFT', 
                                                   Method_Name__c='Credit Card',
                                                   Transaction_Status__c='Declined',
                                                   SalesLookup__c = salesHeaderList[i].Id);
            EFTlist.add(EFTObj);
         }
         return EFTList;
    }
    //Crating Invalid Trasaction status data for EFT_Transaction_Status
    public static list<EFT_Transaction_Status__c> EFTDataWithInvalidStatus(List<SalesHeader__c>
                                                   salesHeaderList,Integer num) {
        
        List<EFT_Transaction_Status__c> EFTList = new List<EFT_Transaction_Status__c>();
        for (integer i=0; i < num; i++) {
            EFT_Transaction_Status__c EFTObj = new EFT_Transaction_Status__c(Name='TestEFT', 
                                                   Method_Name__c='Credit Card Address Verify',
                                                   Transaction_Status__c='Accepted',
                                                   SalesLookup__c = salesHeaderList[i].Id);
            EFTlist.add(EFTObj);
         }
         return EFTList;
    }
//*****************************************VF PAGES DATA********************************************
    public static List<Account> createTestRecordsForAccount(Integer num,String name) {
        List<Account> acccountList = new List<Account>();         
        for (Integer i = 0; i < num; i++) {
            Account accountInstance = new Account(Name = name + i);
            acccountList.add(accountInstance);
        }
        //insert acccountList;
        return acccountList;
    }
    public static List<Contact> createTestRecordsForContact(Integer num) {
        List<Contact> contactList = new List<Contact>();         
        for(Integer i = 0; i < num; i++) {
            Contact contactInstance = new Contact(LastName = 'TestContact' + i);
            contactList.add(contactInstance );
        }
        //insert contactList;
        return contactList;
    }
//**********************************************DATA FOR COUNTRY************************************
    public static list<Country__c> countryData(Integer num) {
        List<Country__c> countryList = new List<Country__c>();
            for (integer i = 0; i < num; i++) {
                Country__c countryInstance = new Country__c(Name = 'India'+i);
                countryList.add(countryInstance);
            }
        return countryList; 
    }     
    public static list<City__c> cityData(Integer num) {
       List<City__c> cityList = new List<City__c>();
            for (integer i = 0; i < num; i++) {
                City__c cityInstance = new City__c(Name = 'Pune'+i);
                cityList.add(cityInstance);
            }
<<<<<<< HEAD
       return cityList;   
=======
        return cityList;  
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
    }    
//****************************************DATA FOR OPPORTUNITY************************************** 
public static list<Opportunity> oppData(Integer num) {
        List<Account> accList= new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
            for (integer i = 0; i < num; i++) {
                Opportunity oppInstance = new Opportunity(Amount = 30,Name = 'India'+i,
                                          CloseDate = (Date)Date.today(),AccountId = accList[i].Id,
                                          StageName  = 'Closed Won');
                oppList.add(oppInstance);
            }
        return oppList; 
    }          
//****************************************DATA FOR LEAD**************************************
public static List<Lead> leadData(Integer num) {
        List<Lead> leadList = new List<Lead>();         
        for(Integer i = 0; i < num; i++) {
<<<<<<< HEAD
            Lead leadInstance = new Lead(FirstName='TestFirst',LastName = 'TestLast' + i,
                                          Status = 'Open - Not Contacted',Company = 'Eternus',
                                          Email='p@eternussolutions.com',Phone='11111112');
=======
            Lead leadInstance = new Lead(LastName = 'TestContact' + i,Company = 'Eternus',
                                    Status = 'Open - Not Contacted',Email='p@eternussolutions.com');
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
            leadList.add(leadInstance );
        }
        //insert contactList;
        return leadList;
    }
public static List<Lead> leadDiffData(Integer num) {
        List<Lead> leadList = new List<Lead>();         
        for(Integer i = 0; i < num; i++) {
            Lead leadInstance = new Lead(LastName = 'TestContact' + i,Company = 'Eternus',
                                    Status = 'Open - Not Contacted',Email='p1@eternussolutions.com');
            leadList.add(leadInstance );
        }
        //insert contactList;
        return leadList;
    }
}