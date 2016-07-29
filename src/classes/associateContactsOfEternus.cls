/************************************************************************
 Class Name: associateContactsOfEternus
 Created Date:22/7/2015
 Description: This class displays account having name Eternus
*************************************************************************/ 
public class associateContactsOfEternus {

 List<Account> lstupdate;
    
        public void diplayingContactofEternus() {
        List<Account> listacc=[select a.id,a.name,(Select id,name from Contacts)
                                   from Account a where a.name='Eternus'];
            if(listacc!=null && listacc.size()>0){
                lstupdate=new list<Account>();
                
                for(Account acc:listacc){
                    if(acc.Contacts!=null && acc.Contacts.size()>0){
                        integer counter=0;
                        for(Contact ct:acc.Contacts){
                                                
                            counter++;
                        }
                        acc.contact_count__c=counter;
                        lstupdate.add(acc);
                    }
                   else{
                    system.debug('Records not found');
                   }
                }
              update lstupdate;  
            }
            else{
                system.debug('Records not found');
            }
             
        }
}
/*public class associateContactsOfEternus {
    
	public void diplayingContactofEternus() {
    
        //Creating map of Id and List of contact
        Map<Id, List<contact>> conmap= new Map<Id, List<contact>>();
        List<Contact> conlist =[select Account.Id, Name From Contact where Account.Name = 'Eternus'];
        for(Contact con : conlist) {
            
            //Checking if that id already exist in map
            If(conmap.containsKey(con.Account.Id)) {
                //Adding the value of taht key in the list
                conmap.get(con.Account.Id).add(con);
            }
            else {
                //putting values of taht key into list
                conmap.put(con.Account.Id,new list<contact>{con});
            }
            //system.debug(conmap.get(con.account.id));
        }
        //creating list of account
        list<Account> accountList = new list<Account>();
    	
    	//getting the key of map
        for(id setid: conmap.keyset()){
            
           //adding the count of contact to the field 
           accountList.add( new Account (id=setid,contact_count__c=conmap.get(setid).size()));  
        }
    	 //Check if the account list is empty
         if(accountList.size() > 0 && accountList!=NULL)
         	update accountList;  
        else{
            system.debug('No records found');
        }
      }
  }*/