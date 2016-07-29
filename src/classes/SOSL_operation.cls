public class SOSL_operation {
    public void findwordtest(){ 
    	List<List<SObject>> searchList = [FIND 'pooja' IN NAME FIELDS RETURNING contact(name), account(name),lead(name),user(name)];
 
     	contact[] conList = ((List<contact>)searchList[0]);
     	account[] accList = ((List<account>)searchList[1]);
     	lead[] leadList = ((List<lead>)searchList[2]);
     	user[] userList = ((List<user>)searchList[3]);
      	
        for(contact objcon:conList) {
            if(conlist!=null && conlist.size()>0)
            	system.debug(objcon);
            else
               system.debug('Records not found'); 
        }
        for(account objacc:accList) {
            if(accList!=null && accList.size()>0)
            	system.debug(objacc);
            else
               system.debug('Records not found'); 
        }
        for(lead objlead:leadList){
           if(leadList!=null && leadList.size()>0)
          	 system.debug(objlead); 
           else
               system.debug('Records not found'); 
        }
         
        for(user objuser:userList){
            if(userList!=null && userList.size()>0)
             	system.debug(objuser);
             else
               system.debug('Records not found');
        }
                  
         }
    }