/************************************************************************
 Class Name: subclass
 Created Date:14/7/2015
 Description: performs map on account
*************************************************************************/ 
public with sharing class mapforacoount {
	
	//map having name as key and id as values
	public void mapaccount() {
	   List<Account> listacc = [Select Id, Name From Account];
	   if(listacc!=null && listacc.size()>0){
        Map<String,Id> mapacc = new Map<String,Id>();
        for(Account acc: listacc)
            mapacc.put(acc.Name,acc.Id);
            system.debug(mapacc+'\r');
	   }
	   else{
	       system.debug('Records not found');
	   }
    }        

	// Account Id as key and entire Account object as value.
	public void mapaccountobj(){
	   List<Account> listaccobj = [Select Id, Name From Account];
	   if(listaccobj!=null && listaccobj.size()>0){
        Map<Id,Account> mapaccobj = new Map<Id,Account>();
        for(Account accobj: listaccobj)
		    mapaccobj.put(accobj.Id, accobj);
		    system.debug(mapaccobj);
	   }
	   else{
	       system.debug('Records not found');
	   }
    }
   
}