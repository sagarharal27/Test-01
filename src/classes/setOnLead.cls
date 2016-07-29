/************************************************************************
 Class Name: setOnLead
 Created Date:11/7/2015
 Description: This class displays set of leads
*************************************************************************/ 

public class setOnLead {
    set<Id> setid;
    public void displayingSet(){
		list<lead> listlead= [select id from lead limit 10];
        
        if(listlead!=NULL && listlead.size()>0)
        {
		setid= new set<id>();
        for(lead leadobj:listlead)
        	setid.add(leadobj.Id);
        	system.debug('Id'+setid);
		}
        else{
            System.debug('Records Not Found');
        }
	}
}