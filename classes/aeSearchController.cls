/*-----------------------------------------------------------------------
    ACF Solutions
    Created By: Vikas Gadilkar
    Created Date: Feb 2015
    Description: This is aeSearch Page controller to get User and Contact data
-----------------------------------------------------------------------*/

public class aeSearchController {

    public static final String NO_RESULTS = 'Sorry, no results returned with matching string..';
    public static final String SEARCH_STR_LENGTH = 'Please enter at least two characters..';
    public static final String SEARCH_FIELDS = 'Name';
    public static final String USER_FIELDS = 'User(Id, Name)';
    public static final String CONTACT_FIELDS = 'Contact(Name, Email)';

    public List<Contact> contactList         {get; set;}
    public List<User> userList               {get; set;}
    public List<conHelper> contactHelperList {get; set;}

    public String searchText                 {get; set;}
    public String sObjectName                {get; set;}
    public String searchString               {get; set;}


    public class conHelper {
        public String name                   {get; set;}
        public String email                  {get; set;}
    }

    /**
     * Constructor
     */
    public aeSearchController () {
        searchText = ApexPages.currentPage().getParameters().get('searchText');
        sObjectName = ApexPages.currentPage().getParameters().get('sObjectName');
        searchString = searchText;
        soslDemo_method();
        
    }

    /**
     * Method to return the results of the searched text
     */
    public void soslDemo_method() {

       contactList = null;
       userList = null;
       contactHelperList = null;
       String trimmedText = searchText.trim();
       if (trimmedText.length() > 1 ) {
            if (sObjectName.equalsIgnoreCase('Contact')) { 
                contactList = New List<Contact>();
                contactHelperList = New List<conHelper>();

                String escapedString = String.escapeSingleQuotes(trimmedText);
                String searchString = escapedString + '*';
                String searchQuery = 'FIND \'' 
                                   + searchString 
                                   + '\' IN ' 
                                   + SEARCH_FIELDS 
                                   + ' FIELDS RETURNING ' 
                                   + CONTACT_FIELDS;
                List<List <sObject>> searchList = search.query(searchQuery);
                contactList  = ((List<Contact>)searchList[0]);
                for (Contact contactLoopObj : contactList) {
                    conHelper objconHelper = new conHelper();
                    objconHelper.name = contactLoopObj.name;
                    objconHelper.email = contactLoopObj.email;
                    contactHelperList.add(objconHelper);
                }
                if (contactList.isEmpty()) {
                    contactList = null;
                    contactHelperList = null;
                    errorMessage();
                    return;
                }
            } else if (sObjectName.equalsIgnoreCase('User')) {
                userList = New List<User>();

                String escapedString = String.escapeSingleQuotes(trimmedText);
                String searchString = escapedString + '*';
                String searchQuery = 'FIND \'' 
                                   + searchString 
                                   + '\' IN ' 
                                   + SEARCH_FIELDS 
                                   + ' FIELDS  RETURNING ' 
                                   + USER_FIELDS;

                List<List <sObject>> searchList = search.query(searchQuery);
                userList = ((List<User>)searchList[0]);
                if (userList.isEmpty()) {
                    userList = null;
                    errorMessage();
                    return;
                }
            } else {
                contactList = New List<Contact>();
                userList = New List<User>();
                contactHelperList = New List<conHelper>();

                String escapedString = String.escapeSingleQuotes(trimmedText);
                String searchString = escapedString + '*';
                String searchQuery = 'FIND \'' 
                                   + searchString 
                                   + '\' IN ' 
                                   + SEARCH_FIELDS 
                                   + ' FIELDS RETURNING ' 
                                   + USER_FIELDS 
                                   + ',' 
                                   + CONTACT_FIELDS;

                List<List <sObject>> searchList = search.query(searchQuery);
                userList = ((List<User>)searchList[0]);
                contactList  = ((List<Contact>)searchList[1]);
                for (Contact contactLoopObj : contactList) {
                    conHelper objconHelper = new conHelper();
                    objconHelper.name = contactLoopObj.name;
                    objconHelper.email = contactLoopObj.email;
                    contactHelperList.add(objconHelper);
                }
                if (userList.isEmpty() && contactList.isEmpty()) {
                    contactList = null;
                    userList = null;
                    contactHelperList = null;
                    errorMessage();
                    return;
                }
            }
        } else { 
            ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, SEARCH_STR_LENGTH);
            ApexPages.addMessage(errMsg);
            return;
        }
    }

    /**
     * Method to display Error Messages
     */
    public void errorMessage() {
        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, NO_RESULTS);
        ApexPages.addMessage(errMsg);
    }

}