/************************************************************************
 Class Name: addingContactToList
 Created Date:14/7/2015
 Description: This class performs SOQL query
*************************************************************************/ 
public class addingContactToList {
	public void displayingContact(){
		list<contact> listcon =[select id,email,name from contact];
        
        if(listcon!=null && listcon.size()>0){
            for(contact con:listcon){
				System.debug(con);
       		}
        }
        else{
            system.debug('Records not found');
        }
    }
}