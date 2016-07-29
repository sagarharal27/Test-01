/************************************************************************
 Class Name: mapOnAcoount
 Created Date:14/7/2015
 Description: performs map on account
*************************************************************************/ 
public with sharing class mapOnAcoount 
{
	//map having name as key and id as values
	public void mapAccountKeyAsString(){
		List<Account> listacc = [Select Id, Name From Account];
        //Null check
        if(listacc!=NULL && listacc.size()>0){
        //Creating map
    		Map<String,Id> mapacc = new Map<String,Id>();
        	for(Account acc: listacc){
      			mapacc.put(acc.Name,acc.Id);
        	}
     		system.debug(mapacc+'name as Key');
    	}
        else{
            system.debug('Records not found');
        }
	}

	// Account Id as key and entire Account object as value.
	public void mapAccountKeyAsId(){
		List<Account> listaccobj = [Select Id, Name From Account];
        if(listaccobj!=NULL && listaccobj.size()>0){
        	//Creating map
    		Map<Id,Account> mapaccobj = new Map<Id,Account>();
    		for(Account accobj: listaccobj)
				mapaccobj.put(accobj.Id, accobj);
			system.debug(mapaccobj+'Id as Key');
        }
        else{
            system.debug('Records not found');
        }
    }
}