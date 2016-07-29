/************************************************************************
 Class Name: Avoid_duplication_ofContact_TestClass
 Created Date:2/8/2015
 Description: This test class ckecks duplication of contact record 
*************************************************************************/  

@isTest
public class Avoid_duplication_ofContact_TestClass {   
    //Create list of contact 
    static List<Contact> dupliConList=new List<Contact>();
    //create list of contact for duplication
    static List<Contact> conList =new List<Contact>(); 
    
    //Testmethod 1: checks with all valid fields     
    public static testMethod void dupliocationWithAllField() { 
        
        //getting list from TestDatafactory
        conList = TestDatafactory.contactData(40);
        //inserting a list
<<<<<<< HEAD
        if(!conList.isEmpty()) {
            insert conList;
        }
        else {
            System.debug('No recordss');
        }   
=======
        insert conList;   
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
                 
        for(Contact conInstance: conList) {
            //creating new instance for duplication
            Contact contObj = new Contact();
            //assigning duplicate value
            contObj.Email = conInstance.Email;
            contObj.Phone = conInstance.Phone;
            //adding values to duplicate list
            dupliConList.add(contObj);
        } 
        System.debug('conList::'+conList);
        test.startTest();
            try{
                //inserting duplicate list
                insert dupliConList;
            }
            catch(Exception e){
                //checking actual and expected result
                system.assertEquals(true, Avoid_duplication_contactHandler.isError);
            }
        test.StopTest(); 
    }
    //Testmethod 2: checks with duplicate phone number
    public static testMethod void duplicationOfPhone() {
        //getting list from TestDatafactory
        conList=TestDatafactory.contactData(40);
        //inserting a list
<<<<<<< HEAD
        if(!conList.isEmpty()) {
            insert conList;
        }
        else {
            System.debug('No record..');
        }   
=======
        insert conList;   
>>>>>>> 35da6db775fa3db33f698ebd618b5131d9cc0bb1
               
        for(Contact conInstance: conList) {
            //creating new instance for duplication
            Contact contObj = new Contact();
            //assigning duplicate value of phone
            contObj.Phone = conInstance.Phone;
            contobj.Email='test@yahoo.com';
            //adding values to duplicate list
            dupliConList.add(contObj);
        }
        System.debug('conList::'+conList);
        test.startTest();
            try{
                //inserting duplicate list
                insert dupliConList;
            }
            catch(Exception e){
                 //checking actual and expected result
                system.assertEquals(true, Avoid_duplication_contactHandler.isError);
            } 
        test.StopTest();  
    }
     //Testmethod 3: checks with duplicate Email
    public static testMethod void duplicationOfEmail() {
        //getting list from TestDatafactory
        conList = TestDatafactory.contactData(40);
        //inserting a list
        insert conList; 
        
        for(Contact conInstance: conList) {
            //creating new instance for duplication
            Contact contObj = new Contact();
             //assigning duplicate value of Email
            contObj.Email = conInstance.Email; 
            contObj.Phone='123';
            //adding values to duplicate list
            dupliConList.add(contObj);
        }
        System.debug('conList::'+conList);
        test.startTest();
            try{
                //inserting duplicate list
                insert dupliConList;
            }
            catch(Exception e){
                //checking actual and expected result
                system.assertEquals(true, Avoid_duplication_contactHandler.isError);
            } 
        test.StopTest();  
    }
    //Testmethod 4: checks with duplicate Phone and null value of Email
    public static testMethod void nullForEmailAndDuplicatePhone() {
        //getting list from TestDatafactory
        conList = TestDatafactory.contactData(40);
        //inserting a list
        insert conList; 
       
        for(Contact conInstance: conList) {
            //creating new instance for duplication
            Contact contObj = new Contact();
             //assigning duplicate value of Phonee
            contObj.Phone = conInstance.Phone;
            //adding values to duplicate list
            dupliConList.add(contObj);
        }
          System.debug('conList::'+conList);
        test.startTest();
          
            try{
                //inserting duplicate list
                insert dupliConList;
            }
            catch(Exception e) {
                //checking actual and expected result
                system.assertEquals(true, Avoid_duplication_contactHandler.isError);
            } 
        test.StopTest();  
    }
    //Testmethod 3: checks with duplicate Email while updation
    public static testMethod void updateData() {
        //getting list from TestDatafactory
        conList = TestDatafactory.contactData(40);
        insert conList; 
        
        for(Contact conInstance: conList) {
            //creating new instance for duplication
            Contact contObj = new Contact();
            contObj.Email = conInstance.Email;
            //adding values to duplicate list
            dupliConList.add(contObj);
        }
         System.debug('conList::'+conList);
         test.startTest();
         try{
            //updating duplicate list
            update conList;
            }  
            catch(Exception e){
                //checking actual and expected result
                system.assertEquals(true, Avoid_duplication_contactHandler.isError);
            } 
        test.StopTest();  
    }
}