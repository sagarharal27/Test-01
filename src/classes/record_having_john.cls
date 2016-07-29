public class record_having_john {
    public record_having_john()
    {
        List<C_object__c> alist=[select id , A_object__r.id,B_object__r.id from C_object__c where Name__c='%john%'];
        System.debug(alist);

    }
 
}