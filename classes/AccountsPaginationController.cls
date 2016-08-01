public with sharing class AccountsPaginationController {
    
    public final String QUERY = 'SELECT Id, Name, Email, Phone FROM Account ';
    public List<Account> accountList   {get; set;}
    public Integer INT_LIMIT = 15;
    public Integer INT_OFFSET = 0;
    public Integer size;
    public Boolean isPrev {get; set;}
    public Boolean isFirst {get; set;}

    public AccountsPaginationController() {
        getAccounts();
    }

    public List<Account> getAccounts() {
        if(INT_OFFSET == 0) {
            isFirst = false;
        }
        if(INT_OFFSET > 0) {
            isFirst = true;
            
        }

        accountList = [SELECT Id
                            , Name
                            , Phone 
                         FROM Account 
                        //WHERE Name = 'qwerty'
                        LIMIT :INT_LIMIT 
                       OFFSET :INT_OFFSET
        ];
        size = accountList.size();
        if(accountList.isEmpty()) { 
            System.debug('INT_OFFSET >>>> EMPTY');
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'No Records !!');
        }
        if(accountList == null ) {
            //accountList = null;
            //ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'No Records !!');
        }
        return accountList;
    }

    public void firstPage() { 
        INT_OFFSET = 0;
        isPrev = false;
        //System.debug('INT_OFFSET >>>> firstPage ' + INT_OFFSET);
        System.debug('INT_OFFSET >>>> firstPage ' + INT_OFFSET);
        getAccounts();
    }

    public void nextPage() {
        INT_OFFSET = INT_LIMIT + INT_OFFSET;
        isPrev = true;
        System.debug('INT_OFFSET >>>> nextPage ' + INT_OFFSET);
        getAccounts();
    }

    public void previousPage() {
        INT_OFFSET = INT_OFFSET - INT_LIMIT;
        System.debug('INT_OFFSET >>>> previousPage ' + INT_OFFSET);
        getAccounts();
    }

    public void lastPage() {
        INT_OFFSET = size - math.mod(size, INT_LIMIT);
        System.debug('INT_OFFSET >>>> lastPage ' + INT_OFFSET);
        System.debug('math.mod(size, INT_LIMIT) >>>> lastPage ' + math.mod(size, INT_LIMIT));
        getAccounts();
       // OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
    }

}