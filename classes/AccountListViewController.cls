/**
 * Controller class to manage accounts and their related contacts
 */
 global with sharing class AccountListViewController {
   
    // Account and contact list
    public List<Account> accountList;
    public List<Contact> contactList;
    
    // Send the account id to the contact page
    public Id idAccount {get; set;}
    
    // Send the account name to the contact page
    public String accountName {get; set;}
    
    // Send the account name to the contact page
    public Boolean areAllSelected {get; set;}
    
    // Get the search string passed on the page
    public String searchStringAccount {get; set;}
    
    // List to display the alphabets
    public List<String> getListAToZ;
    
    // Check the length of the account string passed to be searched 
    public Boolean checkString;
    
    // Get the list of contacts of that perticular alphabet
    public String alphabetName {get; set;}
    
    // Delete the contact via VF remoting
    public Id contactId {get; set;}
    
    // Integer to display the count of account and contacts
    public Integer counter {get; set;}
    
    // To create a new contact
    public Contact contactInstance {get; set;}
    
    // Contact list with the check box wrapped
    public List<WrapCheckBox> contactWrapperList {get; set;}
    
    // To display the Delete Contacts button 
    public Boolean seen {get; set;}
    
    /**
     * Constructor Initialize the variables 
     */
    public AccountListViewController() {
        contactInstance = new Contact();
        WrapCheckBox instance = new WrapCheckBox(contactInstance);
        seen = true;
        checkString = false;
    }
    
    /**
     * Get all account records and if true get only searched related records
     */
    public List<Account> getAccount() {
        if (checkString == false) {
            
            // Return all the records
            accountList = [
                SELECT 
                    Id, 
                    Name, 
                    Website, 
                    Phone, 
                    Email_Address__c 
                FROM 
                    Account
                Limit 50
            ];
            counter = accountList.size();
        } else {
            
            // Get the records by their name entered in the search text box
            accountList = [
                SELECT 
                    Id,
                    Website, 
                    Phone, 
                    Name, 
                    Email_Address__c  
                FROM 
                    Account 
                WHERE 
                    Account.Name LIKE : '%' + searchStringAccount.trim() + '%' 
            ]; 
            counter = accountList.size();
        }
        return accountList;
    }
    
    /**
     * Redirect to contact page with account name and id
     */
    public PageReference redirectToContacts() {
        PageReference contactPage = Page.ContactsListPage;
        
        // Passing the id and name across the page
        contactPage.getParameters().put('aid', idAccount);
        contactPage.getParameters().put('aname', accountName);
        contactPage.setRedirect(true);
        return contactPage;
    }
    
    /**
     * If flag is false get all contacts related to the account 
     */
    public List<Contact> getContactList() {
        idAccount = ApexPages.currentPage().getParameters().get('aid');
        if (checkString == false) {
            
            // Get those contact records whos id is similar to the id passed
            accountName = ApexPages.currentPage().getParameters().get('aname');
            contactList = [
                SELECT 
                    Id, 
                    Name 
                FROM 
                    Contact 
                WHERE 
                    Account.id = :idAccount
            ];
            counter = contactList.size();
            return contactList;
        } else {
        
            // Get those contact records which are related to account.
            contactList = [
                SELECT 
                    Id, 
                    Name 
                FROM 
                    Contact 
                WHERE 
                    Name LIKE :alphabetName + '%' 
                AND 
                    Account.id = :idAccount
            ];
            counter = contactList.size();
            return contactList;
        }
    }
    
    /**
     * Redirect back to the Account page 
     */
    public PageReference returnToAccount() {
        PageReference accountPage = Page.AccountListView;
        accountPage.setRedirect(true);
        return accountPage;
    }
    
    /**
     * Add A to Z to the list.
     */
    public List<String> getListAToZ() {
        getListAToZ = new List<String>{
            'A', 
            'B', 
            'C', 
            'D', 
            'E', 
            'F', 
            'G', 
            'H', 
            'I', 
            'J', 
            'K', 
            'L', 
            'M', 
            'N', 
            'O', 
            'P', 
            'Q', 
            'R', 
            'S', 
            'T', 
            'U', 
            'V', 
            'W', 
            'X', 
            'Y', 
            'Z'
        };
        return getListAToZ;
    }
    
    /**
     * Search an Account
     */
    public void searchResultAccount() {
        if (searchStringAccount.length() < 3) {
            
            // Character count < 3 
            checkString = false;
            ApexPages.addmessage(
                new ApexPages.message(
                    ApexPages.severity.info, 
                    'Please enter min 3 characters to search'
                )
            );
        } else {
            
            // Character count > 3
            checkString = true;
        }
    }
    
    /**
     * Search the Contact result.
     */
    public void searchAlphabets() {
        checkString = true;
        getContactList();
    }
    
    /**
     * Saving new record to contact 
     */
    public void newContact() {
        contactInstance.AccountId = idAccount;
        if (contactInstance.LastName != null) {
            insert contactInstance;
        }
        contactInstance.clear();
        contactInstance.LastName = null;
        contactInstance.Email = null;
        contactInstance.Phone = null;
    }
    
    /**
     * Clears the search result.
     */
    public void clearSearchResult() {
        checkString = false;
        searchStringAccount = '';
    }
    
    /**
     * Delete the account related records from the Contacts.
     */
    @RemoteAction
    global static void deleteRelatedContact(Id contactId) {
        Contact deleteContact = new Contact();
        // Get the Contact record to be deleted.
        deleteContact = [
            SELECT 
                id 
            FROM 
                Contact 
            WHERE 
                id = :contactId
        ];
        
        // Check if contactInstance is not null
        if (deleteContact != null) {
            delete deleteContact;
        }
    }
    
    /** 
     * Display of delete multiple button on check of the delete box 
     * on the contact page to delete multiple contacts 
     */
    public void buttonDisplay() {
        Integer a = 0;
        seen = true;
        for (WrapCheckBox wrapperInstance : contactWrapperList) {
            if (wrapperInstance.deleteBox  == true) { 
                a = a + 1;
                //break;
            }
        }
        if(a > 0 ) {
            seen = false;
        }
    }
    
    /**
     * Adding a checkbox to the contacts retrived 
     */
    public List<WrapCheckBox> getListWrapperMethod() {
        contactWrapperList = new List<WrapCheckBox>();
        for (Contact contact : getContactList()) {
            contactWrapperList.add(new WrapCheckBox(contact)) ;
        }
        return contactWrapperList;
    }
    
    /**
     * Delete the multiple contacts whos checkbox is checked
     */
    public void deleteRecords() {
        List<Contact> deleteContactList = new List<Contact>();
        //seen = true;
        for (WrapCheckBox wrapperInstance : contactWrapperList) {
            if (wrapperInstance.deleteBox  == true) {
                deleteContactList.add(wrapperInstance.contactInstance); 
            }
        }
        delete deleteContactList;
    } 
    
    /**
     * Wrapper class to bind the contact with the delete check box
     */
    public class WrapCheckBox {
        public Boolean deleteBox {get; set;}
        public Contact contactInstance {get; set;}
        
        /**
         * Wrapper constructor to initialize the variables
         */
        public WrapCheckBox(Contact contactObject) {
            deleteBox = false;
            contactInstance = contactObject;
        }
    }
}