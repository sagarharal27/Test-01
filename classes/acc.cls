public class acc {
    public acc() {
        List<Account> accList = new List<Account>();
        Set<Id> accId = new Set<Id>();
        Account acc1 = new Account(Name = 'adminadminadmin');
        insert acc1;
        accId.add(acc1.Id);
        
        
        for(integer i = 0; i < 150; i++) {
            Account a = new Account(Name = 'test1');
            try{
                insert a;
                accId.add(a.Id);
                system.debug('acc size  '+ i + '  > ' +accId.size());
            }
            catch(Exception e) {
                system.debug(e);
            }
        }
        //insert (new Account(Name = 'lastAccount'));
        
        Account acc2 = new Account(Name = 'test');
        insert acc2;
        accId.add(acc2.Id);
        
         accList = [SELECT Id FROM Account WHERE Id in :accId];
        system.debug('acc size'+accList.size());
    }
}