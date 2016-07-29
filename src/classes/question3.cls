/*******************************************************************************
 Class Name: lead_status_closed
 Created Date:11/7/2015
 Description: This class displays lead record havingstatus as Closed - Not Converted
*******************************************************************************/ 
    
    public class question3 {
        public void eternus(){
     list<contact> Contact_list_associated_to_eternus=new list<contact>([select name from contact where Account.name like 'eternus%']);
        integer count=0;
        for(contact c : Contact_list_associated_to_eternus ){
            count++;   
        }        
       list<account> Account_list=new list<account>([select contact_count__c from account where Account.name = 'eternus']);  
        for(account a :Account_list ){
            a.contact_count__c = count;
        }
        update Account_list;
     
        }
    }