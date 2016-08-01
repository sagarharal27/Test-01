/**
 * Controller class for the Query builder page
 */
public with sharing class MultiObjectController {
    
    public boolean queryBlock {get; set;}
    
    // Map to get all the objects 
    Map<String, Schema.SObjectType> objectSchemaMap = Schema.getGlobalDescribe();
    
    // List to store the fields ofthe selected object
    public List<SelectOption> objectFields = new List<SelectOption>();
    
    // Object selectd from the object list
    public String selectedObject{get; set;}
    
    // Select list variables to transfer the values from lift to right
    public List<String> moveright {get; set;} 
    
    // Select list variables to transfer the values from lift to right
    public List<String> moveLeft {get; set;}
    
    // Contains all the fields to work ... taken to perform function on them
    public Set<String> objFields = new Set<String>();
    
    // Set to display the fields on the right picklist
    public Set<String> setRight = new Set<String>();
    
    //  
    public List<SelectOption> displayLeft {get; set;}
    
    //Set<String> setLeft = new Set<String>();
    //Set<String> toAdd = new Set<String>();
    
    // Store the limit of the records to be retrived
    public String maxLimit {get; set;}
    
    // Save the Query
    public String queryString {get; set;}
    
    // Get the search text 
    public String searchValue {get; set;}
    
    // Display orderBy list 
    public List<SelectOption> orderOptions {get; set;}
    
    // Order the display of data
    public String orderBy {get; set;}
    
    //public List<String> queryFields = new List<String>();
    
    // Get the result of the searched value 
    public List<List<sObject>> resultList;
    
    // To get the results of the object 
    public List<sObject> records {get; set;}
    
    
    // Query fields to be displayed on page column wise
    public List<String> disp {get; set;}
    
    
    /**
     * Constructor to initialize the variables
     */
    public MultiObjectController () {
        displayLeft = new List<SelectOption>();
        disp = new List<String>();
        moveLeft = new List<String>();
        moveRight = new List<String>();
        records = new List<sObject>();
        selectedObject = '';
        orderBy = 'Asc';
        queryBlock = false;
    }
    
    /**
     * The function to execute the query
     */
    public void executeQuery() {
        System.debug('////////////////////////\n\n' + orderBy);
        disp.clear();
        
        // Query fields 
        disp.addAll(setRight);
        System.debug('\n\n\n\n\n\n\n\n\n\n\n\n    DISPLAY ' + disp);
        
        queryString = 
            'FIND \'' 
                + searchValue + 
            '\' IN ALL FIELDS RETURNING ' 
                + selectedObject + 
            ' (';
        List<String> str;
        
        // Add the selected fields in the search query string
        for (String instance : setRight) {
            queryString += instance + ',';
        } 
        
        queryString = queryString.removeEnd(',');
        queryString += ' Order By Name ' + orderBy +' LIMIT ' + maxLimit;
        queryString += ')';
        System.debug('>>>>>>>>>>>>>>>>>>>>queryString \n\n' + queryString);
        
        // Check the search text length query on it
        try {
            if (searchValue.length() != 0 ) {
                resultList = Search.Query(queryString);
                System.debug('>\n\n\nresultList \n\n' + resultList);
            }
        } catch(Exception e) {
                System.Debug('error message' + e.getMessage());
        }
        records = resultList[0];
        System.debug('>>\n\n\n\n\n\n\n >records  \n\n' + records);
        
    }
    
    /*
     * Remove fields from the queryString
     */
    public PageReference remove() {
        if (displayLeft.size()-1 == 0 ) {
            queryBlock = false;
        }
        
        // Add the selected fields to a set and remove it from the left pick list
        for (String str : moveLeft) {
           objFields.add(str);
           setRight.remove(str);
        }
        displayLeft.clear();
        
        // Add the removed fields to the original picklist
        for (String str : setRight) {
             displayLeft.add(new SelectOption(str, str));
             System.debug('>>>>>\n\n      displayLeft \n\n           str ' + str);
        }
        
        // Ad the existing fields to the original pick list
        for (String str : objFields) {
            objectFields.add(new SelectOption(str, str));
            System.debug('>>>>>>\n\n      objectFields    \n\n        str ' + str);
        }
        System.debug('\n\n\n\n ' + displayLeft);
        return null;
    }
    
    /**
     * Add fields to the query
     */
    public PageReference add() {
        queryBlock = true;
        displayLeft.clear();
        // moveRight is list<String> which is returned from select list
        // add the fields to display in the right picklist 
        // remove the fields from the left picklist
        
        for (String str : moveRight) {
           setRight.add(str);
           objFields.remove(str);
        }
        System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n    ' + objFields);
        System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n    ' + setRight);
        for (String str : setRight) {
            System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n  hey  '+ str);
            displayLeft.add(new SelectOption(str, str));
            System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n  bye  '+ displayLeft);
        }
        System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n    '+ displayLeft);
        return null;
    }
    
    /**
     * Take all the fields in set to perform operations
     */
    public void generateFields() {
        if (selectedObject != '') {
            Schema.SObjectType objectSchema = objectSchemaMap.get(selectedObject);
            Map<String, Schema.SObjectField> fieldMap = objectSchema.getDescribe().fields.getMap();
            objFields.clear();
            for (String fieldInstance : fieldMap.keySet()) {
                objFields.add(fieldInstance);
            }
        } else {
            System.debug('Have a nice day');
        }
    }
    
    /**
     * Display the fieds of the related objects
     */
    public List<SelectOption> getObjectFields() {
        objectFields.clear();
        
        // Get the selected object from the page
        for (String fieldInstance : objFields) {
            objectFields.add(new SelectOption(fieldInstance, fieldInstance));
        }
        return objectFields;
    }
    
    /**
     * Display all objects
     */
    public List<SelectOption> getObjectNames() {
        List<SelectOption> sortedObjects = new List<SelectOption>();
        
        // Get the objects names in the list
        List<String> objectNames = new List<String>(objectSchemaMap.keySet());
        
        // Sorting the objects 
        objectNames.sort();
        
        // Addd the objects to a select option to display it on the page
        sortedObjects.add(new SelectOption('', ''));
        for (String objectInstance : objectNames) {
            sortedObjects.add(new SelectOption(objectInstance, objectInstance));
        }
        return sortedObjects;
    }
}