public with sharing class Account_clone_handler 
{
public static boolean firstRun = true; 
    public static void CloningAccount(List<Account> lstAccountInstance) {
        system.debug('*******into to handler');
        list<Account> ListAcc =new list<Account>();
        for(Account AccInstance:lstAccountInstance) {
            system.debug(AccInstance + 'AccInstance:::');
            ListAcc.add(AccInstance.clone());
        }
        if(firstRun==true) {
            firstRun=false;
            Insert ListAcc ;
        }
    }
}