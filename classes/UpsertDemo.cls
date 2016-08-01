public class UpsertDemo 
{
    public  UpsertDemo()
    {
        list<Asset> aslist =  new list<Asset>();
        for(integer i=0;i<10;i++)
            aslist.add(new Asset(Name='ABC11'+i,Line_Item_Id__c='DEF'+i,AccountId='00128000004mq9t'));
        try
        {
            upsert aslist Line_Item_Id__c;
        }
        catch(Exception e)
        {
            system.debug('Exception Occured:'+e);
        }
    }
}