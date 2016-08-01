/* Prepare the Map structure to show the Account (As key) 
* and Its opportunities as List(Value)
* Hint : Query on Account and get the child opportunities or
* Query on Opportunities and get the parent Account Id
*/

public class UpdateAccount {
    public UpdateAccount() {
        List<Account> updateName = [Select Name 
                                    from Account 
                                    where Name 
                                    like 'A%' ];
        System.debug(updateName.size());
        for(Account accountInstance: updateName)
            accountInstance.Name='Updated via update DML operation';
        System.debug(updateName);
        update updateName;
    }

}