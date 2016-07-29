/****************************************************************************************
 Class Name: whileloop
 Created Date:11/7/2015
 Description: This class uses Traditional and advanced for loop to diplay Account record
*****************************************************************************************/ 
public class displayingRecordsUsingLoops {
	//Creating list
	list<Account> listacc = [select id, accountnumber from Account];
    set<Id> setid;
    
    //displaying record Using Traditional For Loop
	public void  displayUsingTraditionalForLoop(){      
       for(integer i=0; i<listacc.size(); i++)
       {
           system.debug(listacc[i]);
       }
    }
    //displaying record Using Advanced For Loop
 	public void  displayUsingAdvancedForLoop(){
        for(Account acc: listacc){
            system.debug(acc);
        }
	}
     //displaying record Using while Loop
    public void diplayingListUsingWhileLoop(){
        
        list<Account> listacc = [select id, accountnumber,Rating from Account];
        if(listacc!=NULL && listacc.size()>0){
        integer i=0;
        integer no=listacc.size();
         while(no!=0)
         {
			system.debug('Id:'+listacc[i].id+'Name:'+listacc[i].accountnumber);
        	i++; 
            no--;
    	}
        }
        else
            system.debug('Records not found');
	}
	//Displaying record using set
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
    //Displaying records having account name as Eternus
    public void eternusNameInAccout()
    {
        list<contact> conList=new list<contact>([select name from contact where Account.name like 'eternus%']);
        integer count=0;
        for(contact con : conList ){
            count++;   
        }        
       list<account> accountList=new list<account>([select contact_count__c from account where Account.name = 'eternus']);  
       for(account acc :accountList ){
            acc.contact_count__c = count;
        }
        update accountList;
     }
    
    //Changing status of lead if its Closed not converted
    public void leadRecordStatusClosed(){
        List<Lead> LeadList = [Select Id, Name, Status
                               FROM Lead
                               WHERE Status = 'Closed - Not Converted'];
        if(LeadList !=NULL && LeadList.size()>0){
            System.debug(LeadList + 'inside:::');
            for(Lead L : LeadList){
                L.Status = 'Status changed';
        }
            Update LeadList;
            System.debug(LeadList);
        }
        else
            system.debug('Records not found');
	}
}