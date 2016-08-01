// Delete all inactive Account records created in last 90 days.

public class InActiveAccount {
    public InActiveAccount() {
        List<Account> inActiveAccountList= [SELECT id, name , CreatedDate 
                              FROM Account 
                              WHERE Active__c ='No' 
                              AND CreatedDate = LAST_90_DAYS];
        if(inActiveAccountList != NULL) {
            try{
                delete inActiveAccountList;
            }
            catch(DMLException e) {
                System.debug('Error : ' + e.getMessage());
            }
        }
    }   
}