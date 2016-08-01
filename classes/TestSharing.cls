public with sharing class TestSharing {
                        public TestSharing() {
        List<Account> acc = [SELECT lobo__Person_Email__c From Account WHERE Id = '0012800000YZHa7' ];
		System.debug('>>> ' + acc);  
    }
        
}