public with sharing class having_media 
{
	public void having_media_industry()
    {
        //public void ChildToParent(){
 	    List<Contact> clist=[select Name,Account.Name from Contact where Account.active__c='yes' AND Account.Industry='media'];
         System.debug(clist);
       }
        
		//List<Contact> conlist=[select id,name from Contact where Account.Industry='media'];
        //System.debug(conlist);
    }