public with sharing class UtilityForTest {

    public static final Map<String, Map<String, Schema.SObjectField>> FieldMapCache = 
        new Map<String, Map<String, Schema.SObjectField>>();

    public static final Map<String, Schema.SObjectType> GlobalDescribe = Schema.getGlobalDescribe();

    // Get System Admin User data
    public static final User ADMIN_USER = [ 
         SELECT Id, 
                Name, 
                Email 
           FROM User 
          WHERE Profile.Name = 'System Administrator' 
            AND IsActive = true 
          LIMIT 1
    ];

    /**
     *  Methods to peform DML operation on list record.
     */

    // Insert List of records and Assert.
    public static Database.SaveResult[] insertListWithAssert(List<sObject> sObjectsList) {
        Database.SaveResult[] arrSaveResult;
        if (sObjectsList[0].getSObjectType() == Schema.User.sObjectType) {
            System.runAs(ADMIN_USER) {
                arrSaveResult = Database.insert( sObjectsList);
            }
        } else {
            arrSaveResult = Database.insert( sObjectsList);
        }
        for (Database.SaveResult saveResult : arrSaveResult) {
            System.assert(saveResult.isSuccess());
        }
        return arrSaveResult;
    }

    // Update List of Records with Assert.
    public static Database.SaveResult[] updateListWithAssert(List<sObject> sObjectsList) {
        Database.SaveResult[] arrUpdateResult = Database.update(sObjectsList);
        for(Database.SaveResult saveResult : arrUpdateResult) {
            System.assert(saveResult.isSuccess());
        }
        return arrUpdateResult;
    }

    //Delete List of records with Assert.
    public static Database.DeleteResult[] deleteListWithAssert(List<sObject> sObjectsList) {
        Database.DeleteResult[] arrDeleteResult = Database.delete(sObjectsList);
        for(Database.DeleteResult deleteResult : arrDeleteResult) {
            System.assert(deleteResult.isSuccess());
        }
        return arrDeleteResult;
    }

    /**
     *  Methods to peform DML operation on single record.
     */

    // Insert Single Record and Assert.
    public static Database.SaveResult insertWithAssert(sObject dataObject) {
        Database.SaveResult saveResult = Database.insert(dataObject);
        System.assert(saveResult.isSuccess());
        return saveResult;
    }

    // Update Single Record and Assert.
    public static Database.SaveResult updateWithAssert(sObject dataObject) {
        Database.SaveResult saveResult = Database.update(dataObject);
        System.assert(saveResult.isSuccess());
        return saveResult;
    }
    
    // Upsert Single Record and Assert.
    public static Database.Upsertresult upsertWithAssert(sObject dataObject) {
        Database.Upsertresult upsertResult = Database.upsert(dataObject);
        System.assert(upsertResult.isSuccess());
        return upsertResult;
    }
    
    // Delete single Record and Assert.
    public static Database.DeleteResult deleteWithAssert(sObject dataObject) {
        Database.DeleteResult deleteResult = Database.delete(dataObject);
        System.assert(deleteResult.isSuccess());
        return deleteResult;
    }

    // Get a random value.
    public static String RandomStringValue(Integer Length) { 
        String strValue = 'TestValue' + math.rint(math.random() * 100000);
        if (Length != null && strValue.length() > Length) {
            strValue = strValue.substring(0, Length);
        }
        return strValue;
    }

/**/
/*
    public static List<sObject> createTestRecordList(
        String  sObjectType, 
        Integer numberOfRecords, 
        Boolean doInsert, 
        Integer depth,
        List <Map <String,Object>> recordDefaultValueMapList
    ) { 
        List<sObject> sObjectList = new List<sObject>(); 
        Map<String,Schema.DescribeFieldResult> requiredFieldMap = getNullabelRequiredFields(sObjectType);
        sObject record = null;
        Schema.SObjectType sObjectTypeRequested = GlobalDescribe.get(sObjectType);
        for (Integer recordCount = 0; recordCount < numberOfRecords; recordCount++) {
            record = sObjectTypeRequested.newSobject();
            //Map<String, Object> recordValuesMap;
            //if (recordDefaultValueMapList != null && recordCount < recordDefaultValueMapList.size()) {
            //    recordValuesMap = recordDefaultValueMapList[recordCount];
            //}
            //if (recordValuesMap != null && !recordValuesMap.isEmpty()) { 
            //    for(String strUserField : recordValuesMap.keySet()){ 
            //        record.put(strUserField.trim(),recordValuesMap.get(strUserField));
            //    } 
            //}
            for (String strField : requiredFieldMap.keySet()) {
                if (recordValuesMap == null || recordValuesMap.isEmpty() || !recordValuesMap.containsKey(strField)) {
                    try {
                        if (!recordDepthCountMap.containsKey(strField)) { 
                            recordDepthCountMap.put(strField,depth);
                        }
                        record.put(strField,getFieldValue(record, requiredFieldMap.get(strField), depth));
                    } catch(Exception e) {
                        system.debug('Exception >>>>> : '+ e);
                        system.debug('Exception StackTrace >>>>> : '+ e.getStackTraceString());
                        system.debug('strField >>>>> : '+ strField);
                    }
                }
            }
            sObjectList.add(record);
        }
        if(doInsert) {
            InsertListWithAssert(sObjectList);
        }
        return sObjectList;
    }

    public static Object getFieldValue(sObject sObjectRecord, Schema.DescribeFieldResult fieldDescribe, Integer depth) {
        Object FieldValue = null; 
        if (fieldDescribe != null) {
            Schema.DisplayType displayType = fieldDescribe.getType();
            if(fieldDescribe.getName() == 'EmailEncodingKey') {
                FieldValue = 'ISO-8859-1';
            } else if(fieldDescribe.getName() == 'LanguageLocaleKey' || fieldDescribe.getName() == 'LocaleSidKey') {
                FieldValue = 'en_US';
            } else if(fieldDescribe.getName() == 'TimeZoneSidKey') {
               FieldValue = 'America/Los_Angeles';
            } else if(displayType.equals(Schema.DisplayType.Email)) { 
                FieldValue = RandomStringValue(null) +'@email.com';
            } else if(displayType.equals(Schema.DisplayType.DATETIME)){
                FieldValue = DateTime.now();
            } else if(displayType.equals(Schema.DisplayType.URL)) {
                FieldValue = 'https://'+ RandomStringValue(null) +'.com';
            } else if(displayType.equals(Schema.DisplayType.TIME)) {
                FieldValue = Time.newInstance(12, 00, 00, 00);
            } else if(displayType.equals(Schema.DisplayType.BASE64)) {
                FieldValue = Blob.valueOf(RandomStringValue(null));
            } else if (displayType.equals(Schema.DisplayType.Currency) || displayType.equals(Schema.DisplayType.Double)) {
                FieldValue = math.rint( math.random() * fieldDescribe.getDigits() );                
            } else if(displayType.equals(Schema.DisplayType.INTEGER) || displayType.equals(Schema.DisplayType.Percent)) {
                FieldValue = Integer.valueOf(math.rint( math.random() * fieldDescribe.getDigits()));  
            } else if (fieldDescribe.getName() == 'CommunityNickname' && displayType.equals(Schema.DisplayType.STRING)) { 
                FieldValue = 'test'+ string.valueof(math.roundtolong(math.random()*1000000)); 
            } 
            else if (fieldDescribe.getName() == 'UserName' && displayType.equals(Schema.DisplayType.STRING)) { 
                FieldValue = 'test'+ string.valueof(Userinfo.getOrganizationId())+ string.valueof(math.roundtolong(math.random()*1000000))+ string.valueof(Datetime.now()).replace('-','').replace(':','').replace(' ','')+'@test.com';
            } else if(displayType.equals(Schema.DisplayType.STRING) || displayType.equals(Schema.DisplayType.TEXTAREA) || displayType.equals(Schema.DisplayType.ENCRYPTEDSTRING)){
                FieldValue = RandomStringValue(fieldDescribe.getLength());
            } else if(displayType.equals(Schema.DisplayType.Date)) {
                FieldValue = Date.today();
            } else if(displayType.equals(Schema.DisplayType.Phone)) {
                FieldValue = '987654321';
            } else if(displayType.equals(Schema.DisplayType.Reference)) { 
                String referenceObjectType = fieldDescribe.getReferenceTo()[0].getDescribe().getName(); 
                if (referenceObjectType == 'RecordType') {
                    FieldValue = setRecordType(sObjectRecord);
                }else if (referenceObjectType == 'Profile') { 
                    FieldValue = ADMIN_PPROFILE.Id;
                }
                else if(referenceObjectType == 'UserRole')
                {
                    FieldValue = CEO_ROLE.Id;
                }
                else if(fieldDescribe.getName() == 'DelegatedApproverId' && sObjectRecord.getSObjectType().getDescribe().getName() == 'User')
                {
                    FieldValue = ADMIN_USER.Id;
                }
                else if(referenceObjectType == 'Group')
                {
                    FieldValue = ORG_GROUP.Id;
                }  
                else if((referenceObjectType == 'Contact' || referenceObjectType == 'Account') && sObjectRecord.getSObjectType().getDescribe().getName() == 'User')
                {
                    // Does not fill the contact and Account for user as its only for Portal User.
                }
                else if(sObjectRecord.getSObjectType().getDescribe().getName() != 'BusinessHours' && (RecordDepth + 1)  > depth) {                    
                    depth = recordDepthCountMap.get(fieldDescribe.getName());
                    depth = depth + 1;
                    recordDepthCountMap.put(fieldDescribe.getName(),depth);
                    sObject referenceRecord = createTestRecordList(referenceObjectType, 1, true, null, depth)[0];
                    FieldValue = referenceRecord.Id;
                }
            }
        }        
        return FieldValue;
    }
*/
    /***/



    public static Map<String,Schema.DescribeFieldResult> getNullabelRequiredFields(String sObjectType) {
        Map<String,Schema.DescribeFieldResult> describeFieldMap = new Map<String,Schema.DescribeFieldResult>();
        Map<String,Schema.SObjectField> fieldsMap = fieldMapFor(sObjectType);
        for (Schema.SObjectField field : fieldsMap.values()) {
            Schema.DescribeFieldResult fieldMetadata = field.getDescribe();
            //system.debug(':: '+ fieldMetadata.getName() + '::' + fieldMetadata.IsCreateable());
            if (fieldMetadata.IsCreateable() && (!fieldMetadata.IsNillable() /*|| FillAllFields*/) && !fieldMetadata.IsDefaultedOnCreate()) {
                describeFieldMap.put(fieldMetadata.getName(),fieldMetadata);
            }
        }
        return describeFieldMap;
    }

    // Get the fields of the sObject
    public static Map<String, Schema.SObjectField> fieldMapFor(String objectType) {
        Map<String, Schema.SObjectField> fieldMap = null;
        String normalizedObjectType = objectType.toLowerCase();
        if (FieldMapCache.containsKey(normalizedObjectType)) {
            fieldMap = FieldMapCache.get(normalizedObjectType);
        } else {
            fieldMap = GlobalDescribe.get(objectType).getDescribe().fields.getMap();
            // cache it for next use
            FieldMapCache.put(normalizedObjectType, fieldMap);
        }
        return fieldMap;
    }

}