public class AccountDemo {
    public AccountDemo() {
        // Constructor
        List<Account> accountList =[SELECT id 
                                    FROM Account 
                                    WHERE Acc_Type__c = 'Person'];
        
        // Traditional For loop
        for(integer i=0;i<accountList.size();i++) {
            System.debug(accountList[i]);
        } // Traditional for
        // Advanced For loop
        for(Account accountInstance : accountList) {
            System.debug(accountInstance);
        } // Advanced for 
    } // Constructor
} // Class