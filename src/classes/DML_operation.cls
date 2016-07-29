public class DML_operation {
     public void DML_Insert_record()
     {
       List<Lead> Llistof100 = new List<Lead>(); 
      for(Integer i=0; i<100 ;i++)
     { 
         Lead leadL = new Lead(LastName='Test100'+i, Company='Test1 Inc.',
            Status='Status changed', Unique__c= 'abc'+i);
        Llistof100.add(leadL);
     }
     try
     {
         insert Llistof100;
     }
     catch(DMLException e)
     { 
        Logs__c error =new Logs__c(Error__c = e.getMessage());
  		insert error;
        System.debug('The following exception has occurred: ' + e.getMessage());
       }
    }
  public void DMLdeleteInactiveRecord()
  {
    List<Account> accountList= [Select id, name from Account Where Active__c ='No' And CreatedDate = LAST_90_DAYS];
     for(Account a:accountList )
     {  
         System.debug(a);
     }
     Delete accountList;  
  }
    public void assert_record(){
    list<Asset> assetlist =  new list<Asset>();
        for(integer i=0;i<4;i++)
        {
            assetlist.add(new Asset(Name='ABC welcome'+i,Line_Item_Id__c='DEF'+i,AccountId='00128000004UkTX'));
        }
        try{
            upsert assetlist Line_Item_Id__c;
           }
    
    catch(Exception e)
        {
            system.debug('Exception Occured:'+e);
        }
    }
}