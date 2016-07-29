/*****************************************************************************************
 Class Name: Create_case_mappingHandler
 Created Date:20/7/2015
 Description: This Handler class avoids duplication of conatct validating email and phone
*******************************************************************************************/
public with sharing class Avoid_duplication_contactHandler {
    public static boolean isError {get; set;}
    //method avoids duplication
    public static void DuplicateContact(List <Contact> contactList) {
        
        //map of email as key and boolean value
        map <string,boolean> mapEmail=new map <string,boolean>();
        //map of phone as key and boolean value
        map <string,boolean> mapPhone=new map <string,boolean>();

        //checking for email and phone in list
        for (contact conInstance:contactList) {
            mapEmail.put(conInstance.Email,true);
            mapPhone.put(conInstance.Phone,true);
        }
        
        //If email already exist in the list
        for (contact conObj : [select Email
                              from Contact where Email IN :mapEmail.keySet()]) { 
            mapEmail.put(conObj.Email,false);
        }
        //If phone alredy exist in the list
        for (contact conObj : [select Phone
                              from Contact where Phone IN :mapPhone.keySet()]) {
            mapPhone.put(conObj.Phone,false);
        }
        //set the value false if email and phone already exist and display error
        for (Contact conInstance:contactList) {
            if(mapEmail.get(conInstance.Email)== false||mapPhone.get(conInstance.Phone)==false) {
                isError = true;
                conInstance.adderror('Duplication email/phone number is inserted');
                
            }
        }
    }

}
