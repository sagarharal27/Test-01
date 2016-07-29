/****************************************************************************
 Class Name: child_to_parent_operations
 Created Date:14/7/2015
 Description: This class performs operation from child object to parent
				
*****************************************************************************/ 
public class child_to_parent_operations {
    //Record having industry as media
    public void having_media_industry(){
         List<Contact> clist=[select Name,Account.Name
                              from Contact
                              where Account.active__c='yes'
                              AND Account.Industry='media'];
         if(clist!=null && clist.size()>0){
            system.debug(clist);
         }
         else{
             system.debug('Records not found');
         }
    }
	//Record having industry as media
    public  child_to_parent_operations() {
        list<Asset> assetlist =  new list<Asset>();
        for(integer i=0;i<4;i++) {
            assetlist.add(new Asset(Name='ABC welcome'+i,Line_Item_Id__c='DEF'+i,AccountId='00128000004UkTX'));
        }
        try{
            upsert assetlist Line_Item_Id__c;
           }
    
    catch(Exception e) {
            system.debug('Exception Occured:'+e);
        }
    }
}