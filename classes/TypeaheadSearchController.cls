/*-----------------------------------------------------------------------
    ACF Solutions
    Created By: Vikas Gadilkar
    Created Date: Feb 2015
    Description: This is Typeahead VF Component controller 
-----------------------------------------------------------------------*/

global class TypeaheadSearchController { 

    public static final String SEARCH_FIELDS = 'Name';
    public static final String USER_FIELDS = 'User(Id, Name)';
    public static final String CONTACT_FIELDS = 'Contact(Name, Email)';

    public String searchedRecordId               {get; set;}
    public static list<ResultSet> searchedRecord {get; set;}
    public static Set<String> objLabelNameSet;

    /**
     * Method to get the list of records avaliable matching the search text
     */
    @RemoteAction 
    global static ResultSet[] getRecords(String searchText) {
        system.debug('Remote Action ?>>>>>>> ' + searchText);
        searchedRecord = new list<ResultSet>();
        objLabelNameSet = new Set<String>();
        String trimmedText = searchText.trim();
        if (trimmedText.length() > 0) {
            String escapedStr = String.escapeSingleQuotes(trimmedText);
            String soslQuery = 'FIND \'' 
                             + escapedStr 
                             + '*\' IN '
                             + SEARCH_FIELDS 
                             + ' FIELDS RETURNING '
                             + CONTACT_FIELDS
                             + ' , ' 
                             + USER_FIELDS
                             + ' LIMIT 10';

            List<List<SObject>> searchList = search.query(soslQuery);
            for (List<SObject> sObjLoopList : searchList) {
                for (SObject sObjLoopObj : sObjLoopList) {
                    String objLabelName = TypeaheadSearchController.getsObjectNameById((String) sObjLoopObj.get('Id'));
                    if (!objLabelNameSet.Contains((String) sObjLoopObj.get('Name') + ' ' + objLabelName)) {
                        objLabelNameSet.add((String) sObjLoopObj.get('Name') + ' ' + objLabelName);
                        searchedRecord.add(new TypeaheadSearchController.ResultSet(sObjLoopObj));
                   }
               }
            }
        }
        return searchedRecord;
    }

    /*
     * GlobalDescribe method to get the ID of the objects
     */
    private static list<Schema.SObjectType> gd {
        get{
            if (gd == null){
                gd = Schema.getGlobalDescribe().values();
            }
            return gd ;
        } set;
    }

    /**
     * Get object Name by Id by calling the GlobalDescribe method
     */
    public static String getsObjectNameById(String sObjectId) {
        if (sObjectId != null && sObjectId.trim() != '') {
            for (Schema.SObjectType objectInstance : TypeaheadSearchController.gd) {
                if (objectInstance.getDescribe().getKeyPrefix() == sObjectId.subString(0,3)) {
                    return objectInstance.getDescribe().getLabel();
                }
            }
        }
        return null;
    }

    /*
     * Record Wrapper Class
     */
    global class ResultSet {
        public String Id            {get; set;}
        public String Name          {get; set;}
        public String sObjectName   {get; set;}

        /**
         * Wrapper Class Constructor 
         */
        public ResultSet(sObject sObj) {
            this.Id = sObj.Id;
            this.Name = sObj.get('Name') + '';
            this.sObjectName = TypeaheadSearchController.getsObjectNameById(Id);
        }

    }
}