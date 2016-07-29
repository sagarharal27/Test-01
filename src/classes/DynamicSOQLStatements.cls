/***************************************************************************************************
Class: DynamicSOQLStatements
Date : 25/8/2015
Description : This is controller where Dynamic SOQL queries are used 
              to interact with objects and fields  
***************************************************************************************************/
public with sharing class DynamicSOQLStatements {
    
    public String selectObject{get;set;}
    public List<String> selectField{get;set;}
    public String selectRecord{get;set;}
    public List<SelectOption> selct{get;set;}
    public String alpha{get;set;}
    
    public List<String> selectedField{get;set;}
    public List<sObject> dynamicRecordsList{get; set;}
    public List<String> fieldSet;
    public List<SelectOption> objectList{get;set;}
    public List<SelectOption> fieldList{get;set;}
    public List<SelectOption> recordList{get;set;}
    public List<SelectOption> selectedFieldList{get;set;}
    //public list<SelectOption> queryList{get;set;}
 
    public String orderOfOptions{get;set;}
    public String fieldString{get;set;}
    public String concatenatedstring{get;set;}

    //Map to get all the objects where name is the key and the value is the fields of the related object
    public Map<String, Schema.SObjectType> mapToGetObjects = new map<String, Schema.SObjectType>();
    Map<String, Schema.SObjectField> mapToGetFields;
    
    public List<String> objectSet{get;set;}
    public List<String> selectedFieldSet{get;set;}
    public String queryList{get;set;}
    public Boolean blrenderSection{get;set;}
    //public Boolean blrenderSection2{get;set;} 
    public Boolean blRend{get;set;}
    public set<string> setOfSelectedFields{get; set;}
 
    public DynamicSOQLStatements() {
        getObjectList();
        selectedFieldList = new List<selectOption>();
        selectField = new List<String>();
        dynamicRecordsList = new  List<sObject>();
        recordList  = new List<selectOption>();
        selectedFieldSet = new List<String>();
        blRend=false;
        setOfSelectedFields = new set<string>();
    }
    // Method to get the list of objects
    public List<SelectOption> getObjectList() {
        objectList = new List<SelectOption>();
        
        //To get a map of all the sObject names with the values
        mapToGetObjects = Schema.getGlobalDescribe();
        System.debug('11111111111111111'+mapToGetObjects);
        //To get all the keys (names of sObjects) in the objectSet
        objectSet = new List<String>(mapToGetObjects.keySet());
        objectSet.sort();
        System.debug('22222222222222222'+objectSet);
        //To get the list of objects
        for(String obj : objectSet) {
            //getAll.Values();
            objectList.add(new SelectOption(obj,obj)); 
        }
        System.debug('^^^^^^^^^^^^^^^^^^^^'+objectList);
        return objectList;
    }
    // Method to get the list of fields of the objects
    public void getFieldList(){
        fieldList = new List<SelectOption>();
        fieldList.clear();
        System.debug('------------------------------------------------'+fieldList);
        blrenderSection = true;
        //To get a map of all the sObject names with the values
        mapToGetObjects = Schema.getGlobalDescribe();
        System.debug('3333333333333333'+mapToGetObjects);
        //To select a object to show the related fields of the object
        System.debug('4444444444444444'+selectObject);
  
        //Map to get the fields where the API name of the fields is the key and
        //the labels of the field is the value
        mapToGetFields = mapToGetObjects.get(selectObject).getDescribe().fields.getMap(); 
        System.debug('55555555555555555'+mapToGetFields); 
        //To get all the keys(field labels)
        //List<String> fieldSet = new  List<String>();
        fieldSet = new List<String>(mapToGetFields.keySet()); 
        fieldSet.sort();
        System.debug('666666666666666666666'+fieldSet);  
        //To return the list of fields 
        for(String fieldInstance : fieldSet) {
            fieldList.add(new SelectOption(fieldInstance,fieldInstance));
        }
    }
    // Method to show the list of selected field names
    public void showSelectedFieldList(){
        //Only one field is selected   
        System.debug('666666666666666666'+selectedFieldSet);    
        for(String fInstance : selectField) {
            selectedFieldList.add(new selectOption (fInstance,fInstance));
        }
        System.debug('777777777777777777'+selectedFieldList);
        for(String fieldsInstance : selectField) {
            setOfSelectedFields.add(fieldsInstance);
            selectedFieldSet.add(fieldsInstance);
        }
        System.debug('!!!!!!!!!!!!!!!!!!!!!'+selectedFieldSet);
    } 
    // Method to unselect the fields if not needed
    public void undoSelectedFields() {
        for(String toDelete:selectedField) {
            setOfSelectedFields.remove(toDelete);
        }
        selectedFieldList.clear();
        for(String fInstance : setOfSelectedFields) {
            selectedFieldList.add(new selectOption (fInstance,fInstance));
        }
        System.debug('7777777777777777777'+selectedFieldList);
    }
    //Method to show the query
    public void showQuery() {
        blRend=true;
        System.debug('forming query-->');
        if (orderOfOptions == 'Ascending') {
            orderOfOptions = ' ASC';
        }
        if (orderOfOptions == 'Descending') {
            orderOfOptions = ' DSEC';
        }
        queryList = 'SELECT' + selectedFieldSet + 'FROM ' + selectObject + ' ORDER BY ';
        queryList += +selectedFieldSet[0]+ orderOfOptions+ ' LIMIT ' + selectRecord;
        System.debug('88888888888888888888888'+queryList);
        //Replace unwanted characters 
        queryList = queryList.replace('(',' ');
        queryList = queryList.replace(')',' ');
        System.debug('99999999999999999999999'+queryList);
        //List of query 
      } 
     public void executeQuery(){
        dynamicRecordsList = new List<sObject>();
        dynamicRecordsList = Database.query(queryList);
        System.debug('*************'+dynamicRecordsList);
     }
}