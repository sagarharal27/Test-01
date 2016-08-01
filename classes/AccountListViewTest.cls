/**
 *  Test class for the combined VF assignmnet 
 */
@isTest
private class AccountListViewTest {
    static Integer i, k, j = 0;
    
    /**
     * Creating account data for test
     */
    static List<Account> createAccountData() {
        List<Account> accountList = new List<Account>();
        Account accountObject1 = 
            new Account(
                Name = 'testAccount1', 
                Email_Address__c = 'testAccount1@demo.com'
            );
        Account accountObject2 = 
            new Account(
                Name = 'testAccount2', 
                Email_Address__c = 'testAccount2@demo.com'
            );
        accountList.add(accountObject1);
        accountList.add(accountObject2);
        return accountList;
    }
    
    /**
     * Creating contact data for test
     */ 
    static List<Contact> createContactData(Id accountId) { 
        List<Contact> contactList = new List<Contact>();
        Contact contactObject1 = 
            new Contact(
                LastName = 'testContact1', 
                AccountId = accountId
            );
        Contact contactObject2 = 
            new Contact(
                LastName = 'testContact2', 
                AccountId = accountId
            );
        contactList.add(contactObject1);
        contactList.add(contactObject2);
        return contactList;
    }
    
    /**
     * Test the account page and get the list
     */
    static testMethod void testAccountPage() {
        List<Account> accountData = createAccountData();
        insert accountData;
        
        // Verify is account data is inserted successfully
        System.assertEquals(2, accountData.size());
        for (Account accountInstance : accountData) {
            System.assert(accountInstance.Id != null);
        }
         
        Test.startTest();
        PageReference accountPageTest = Page.AccountListView;
        Test.setCurrentPage(accountPageTest);
        AccountListViewController accountControllerInstance = new AccountListViewController();
        accountControllerInstance.getAccount();
        Test.stopTest();
        
        // Check if all accounts are being called
        System.assertEquals(accountData.size(), accountControllerInstance.accountList.size());
    }
    
    /**
     * 
     */
    static testMethod void testSearchAlphabets() {
        
        // Get account data and insert it
        List<Account> accountData = createAccountData();
        insert accountData;
        
        // Verify if account data is inserted successfully
        System.assertEquals(2, accountData.size());
        for (Account accountInstance : accountData) {
            System.assert(accountInstance.Id != null);
        }
        
       // Get the contact data and insert it
        List<Contact> contactData = createContactData(accountData[0].Id);
        insert contactData;
        
        // Verify if contact data is inserted successfully
        System.assertEquals(2, contactData.size());
        for (Contact contactInstance : contactData) {
            System.assert(contactInstance.Id != null);
        }
        
        Test.startTest();
        AccountListViewController controllerInstance = new AccountListViewController();
        controllerInstance.alphabetName = 't';
        controllerInstance.searchAlphabets();
        Test.stopTest(); 
        
        // Verify if the string value is updated to true
        System.assertEquals(true, controllerInstance.checkString);
        
        //  
        //System.assert(AccountListViewController.a.size() != 0);
    }
    
    /**
     * Get the related contacts of a perticular account (Manage Contacts Button)
     */
    static testMethod void testRedirectToContacts() {
        
        // Get account data and insert it
        List<Account> accountData = createAccountData();
        insert accountData;
        
        // Verify if account data is inserted successfully
        System.assertEquals(2, accountData.size());
        for (Account accountInstance : accountData) {
            System.assert(accountInstance.Id != null);
        }
        
       // Get the contact data and insert it
        List<Contact> contactData = createContactData(accountData[0].Id);
        insert contactData;
        
        // Verify if contact data is inserted successfully
        System.assertEquals(2, contactData.size());
        for (Contact contactInstance : contactData) {
            System.assert(contactInstance.Id != null);
        }
        
        Test.startTest();
        PageReference contactsPageTest = Page.ContactsListPage;
        Test.setCurrentPage(contactsPageTest);
        ApexPages.currentPage().getParameters().put('aid', accountData[0].Id);
        AccountListViewController controllerInstance = new AccountListViewController();
        controllerInstance.getContactList() ;
        Test.stopTest();
        
        // Check if account related contacts are retrived
        System.assertEquals(contactData.size(), controllerInstance.contactList.size());
    }
    
    /**
     * Apex Page messages test case 
     */
    static testMethod void apexPageMessageTest() {
        
        Test.startTest();
        AccountListViewController controllerInstance = new AccountListViewController();
        controllerInstance.searchStringAccount = 'ac';
        controllerInstance.searchResultAccount();
        Test.stopTest();
        
        List<Apexpages.Message> message = ApexPages.getMessages();
        Boolean checkMsg = false;
        for(Apexpages.Message pageMsg : message) {
            if (pageMsg.getDetail().contains('Please enter min 3 characters to search'))
                checkMsg = true;
        }
        
        // Check if the error message is being displayed 
        System.assert(checkMsg);
    }
    
    /**
     * Test the search account results
     */
    static testMethod void testSearchAccount() {
        List<Account> accountData = createAccountData();
        insert accountData;
        
        // Verify if account data is inserted successfully
        System.assertEquals(2, accountData.size());
        for (Account accountInstance : accountData) {
            System.assert(accountInstance.Id != null);
        }
        
        Test.startTest();
        PageReference accountPageTest = Page.AccountListView;
        Test.setCurrentPage(accountPageTest);
        AccountListViewController accountListControllerInstance = new AccountListViewController();
        accountListControllerInstance.searchStringAccount = 'testAccount1';
        accountListControllerInstance.checkString = true;
        accountListControllerInstance.getAccount();
        Test.stopTest();
        
        // Check if we are getting account  according to the text entered in the text box
        System.assertEquals(1, accountListControllerInstance.accountList.Size());
    }
    
    /**
     * Test the text box search functionality                                                        DONE
     */
    static testMethod void testSearchResultAccount() {
        
        // Get the account data to be inserted
        List<Account> accountData = createAccountData();
        insert accountData;
        
        // Verify if account data is inserted successfully
        System.assertEquals(2, accountData.size());
        for (Account accountInstance : accountData) {
            System.assert(accountInstance.Id != null);
        }
        
        // Get the contact data to be inserted
        List<Contact> contactData = createContactData(accountData[0].Id);
        insert contactData;
        
        // Verify if contact data is inserted successfully
        System.assertEquals(2, contactData.size());
        for (Contact contactInstance : contactData) {
            System.assert(contactInstance.Id != null);
        }
        AccountListViewController accountListControllerInstance = new AccountListViewController();
        
        Test.startTest();
        PageReference accountSearchPage = Page.AccountListView;
        Test.setCurrentPage(accountSearchPage);
        
        // Passing the id and the name to be searched
        apexPages.currentPage().getParameters().put('aid', accountData[0].id);
        apexPages.currentPage().getParameters().put('searchStringAccount', 't');
        accountListControllerInstance.checkString = false;
        accountListControllerInstance.getAccount();
        Test.stopTest();
        
        // Check that no records are returned as search string < 3 characters
        System.assertEquals(accountData.size(), accountListControllerInstance.accountList.size());
    }
    
    /**
     * Test the A to Z List  
     */
    static testMethod void testAtoZ() {
       AccountListViewController accountListControllerInstance = new AccountListViewController();
       
       Test.startTest();
       List<String> testList = accountListControllerInstance.getListAToZ();
       Test.stopTest();
        
        // Check if we are getting the list of from A to Z
        System.assertEquals(26, testList.size());
    }
    
    /**
     * Redirect to accounts page test case
     */
    static testMethod void returnToAccountTest() {
        PageReference accountPageTest = Page.AccountListView;
        Test.setCurrentPage(accountPageTest);
        AccountListViewController controllerInstance = new AccountListViewController();
        
        Test.startTest();
        String testPage = controllerInstance.returnToAccount().getUrl();
        Test.stopTest(); 
        
        // Verify the url of the account page 
        System.assertEquals('/apex/accountlistview', testPage);
    }
    
    /**
     * Redirect to contacts page test case
     */
    static testMethod void redirectToContactsTest() {
        PageReference contactPageTest = Page.ContactsListPage;
        Test.setCurrentPage(contactPageTest);
        
        Test.startTest();
        AccountListViewController controllerInstance = new AccountListViewController();
        String testPage = controllerInstance.redirectToContacts().getUrl();
        Test.stopTest(); 
        
        // Verify the url of the contact page
        System.assertEquals('/apex/contactslistpage', testPage);
    }
    
    /**
     * Test if account is deleted VF REMOTING 
     */ 
    static testMethod void deleteContactPageTest() {
        Integer contactCount;
        List<Account> accountData = createAccountData();
        insert accountData;
        
        // Verify if account data is inserted successfully
        System.assertEquals(2, accountData.size());
        for (Account accountInstance : accountData) {
            System.assert(accountInstance.Id != null);
        }
        
        List<Contact> contactData = createContactData(accountData[0].Id);
        insert contactData;
        
        // Verify if contact data is inserted successfully
        System.assertEquals(2, contactData.size());
        for (Contact contactInstance : contactData) {
            System.assert(contactInstance.Id != null);
        }
        
        Test.startTest();
        AccountListViewController.deleteRelatedContact(contactData[0].Id);
        Test.stopTest();
        
        List<Contact> contactList = [
            SELECT 
                id 
            FROM 
                Contact
        ];
        
        // Check to see if the contact is deleted
        System.assertNotEquals(contactList.size(), contactData.size());
    }
    
    /**
     * Test the delete multiple contacts button 
     */
    static testMethod void buttonDisplayTest() {
        AccountListViewController controllerInstance = new AccountListViewController();
        controllerInstance.buttonDisplay();
        
        // Check if the search box is cleared
        System.assert(controllerInstance.seen == false);
    }
    
    /**
     * Add new contact from contact page test case
     */
    static testMethod void insertNewContactTest() {
        AccountListViewController controllerInstance = new AccountListViewController();
        
        List<Contact> contactListBefore = [
            SELECT
                Id
            FROM
                Contact
        ];
        
        Test.startTest();
        controllerInstance.contactInstance.LastName = 'testInsert';
        controllerInstance.newContact();
        Test.stopTest();
        
        List<Contact> contactListAfter = [
            SELECT
                Id
            FROM
                Contact
        ];
        
        // Check if contact is inserted successfully
        System.assert(contactListBefore.size() < contactListAfter.size());
    }
    
    /**
     * Test case to test if the search box is being cleared
     */
    static testMethod void clearSearchBoxTest() {
        List<Account> accountData = createAccountData();
        insert accountData;
        
         // Verify if account data is inserted successfully
        System.assertEquals(2, accountData.size());
        for (Account accountInstance : accountData) {
            System.assert(accountInstance.Id != null);
        }
        AccountListViewController controllerInstance = new AccountListViewController();
        
        Test.startTest();
        controllerInstance.searchStringAccount = 'xyz';
        controllerInstance.clearSearchResult();
        Test.stopTest();
        
        // Check if the search box is cleared
        System.assert(controllerInstance.searchStringAccount == '' );
    }
    
    /**
     * Delete the contact records by checking the check box test case 
     */
    static testMethod void deleteRecordsCheckboxTest() {
        List<Account> accountData = createAccountData();
        insert accountData;
        
        // Verify if account data is inserted successfully
        System.assertEquals(2, accountData.size());
        for (Account accountInstance : accountData) {
            System.assert(accountInstance.Id != null);
        }
        List<Contact> contactData = createContactData(accountData[0].Id);
        insert contactData;
        
        // Verify if contact data is inserted successfully
        System.assertEquals(2, contactData.size());
        for (Contact contactInstance : contactData) {
            System.assert(contactInstance.Id != null);
        }
        AccountListViewController controllerInstance = new AccountListViewController();
        List<AccountListViewController.WrapCheckBox> wrapperList = 
            controllerInstance.getListWrapperMethod();
        
        for (AccountListViewController.WrapCheckBox wrapperInstance : 
            controllerInstance.contactWrapperList) {
            wrapperInstance.deleteBox = true;
            controllerInstance.contactWrapperList.add(wrapperInstance);
        }
        
        Test.startTest();
        controllerInstance.deleteRecords();
        Test.stopTest();
        
        wrapperList = controllerInstance.getListWrapperMethod();
        
        // Check if the records are deleted after check of checkbox
        System.assert(wrapperList.isEmpty());
    }
}