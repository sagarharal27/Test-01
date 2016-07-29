/****************************************************************************
 Class Name: DMLOperation
 Created Date:14/7/2015
 Description: This class displays record of opportunity having amount
				greater than 10000
*****************************************************************************/ 
public class DMLOperation {
    //inserting record to lead
     public void DMLInsertRecord(){
     	List<Lead> Llistof100 = new List<Lead>(); 
      	for(Integer i=0; i<100 ;i++){ 
        	Lead leadL = new Lead(LastName='Test100'+i, Company='Test1 Inc.',
        	Status='Status changed', Unique__c= 'abc'+i);
        	Llistof100.add(leadL);
     	}
     try {
         insert Llistof100;
     }
     catch(DMLException e){ 
        Logs__c error =new Logs__c(Error__c = e.getMessage());
  		insert error;
        System.debug('The following exception has occurred: ' + e.getMessage());
       }
    }
    //deleting record fron account which are inactive 
	public void DMLdeleteInactiveRecord() {
  		List<Account> accountList= [Select id, name from Account Where Active__c ='No' And CreatedDate = LAST_90_DAYS];
    	if(accountList!=null && accountList.size()>0){
    	   for(Account a:accountList ) {  
        	   System.debug(a);
    	   }
    	}
    	else{
            system.debug('Records not found');
        }
     Delete accountList;  
  }
    //upserting records to aseet
	public void assetRecord(){
    	list<Asset> assetlist =  new list<Asset>();
        for(integer i=0;i<4;i++){
            assetlist.add(new Asset(Name='ABC welcome'+i,Line_Item_Id__c='DEF'+i,AccountId='00128000004UkTX'));
        }
        try{
            upsert assetlist Line_Item_Id__c;
           }
    
    catch(Exception e){
    	system.debug('Exception Occured:'+e);
        }
    }
}