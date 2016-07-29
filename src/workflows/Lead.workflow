<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Follow_up_date</fullName>
        <description>Follow up date</description>
        <protected>false</protected>
        <recipients>
            <recipient>pooja.jadhav@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SalesNewCustomerEmail</template>
    </alerts>
    <fieldUpdates>
        <fullName>DNC_rule</fullName>
        <description>This is rule for DNC in lead</description>
        <field>RecordTypeId</field>
        <lookupValue>DNC</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>DNC rule</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Landline_rule</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Landline</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Landline rule</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mobile_number</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Mobile</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Mobile number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>No_number</fullName>
        <description>Changes the field to no number</description>
        <field>RecordTypeId</field>
        <lookupValue>NO_number</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>No number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>lead_of_mobile</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Mobile</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>lead of mobile</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Change in Follow up date</fullName>
        <actions>
            <name>Follow_up_date</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Send Email if follow up date is older than today</description>
        <formula>Follow_up_of_date__c &lt; TODAY()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DNC rule</fullName>
        <actions>
            <name>DNC_rule</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Rule for lead(DNC)</description>
        <formula>DoNotCall == TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Landline rule</fullName>
        <actions>
            <name>Landline_rule</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Rule for lead(Landline)</description>
        <formula>AND( DoNotCall == FALSE, ISBLANK( MobilePhone ) , NOT( ISBLANK( Phone ) ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Mobile number rule</fullName>
        <actions>
            <name>Mobile_number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Rule for lead(mobile)</description>
        <formula>IF(NOT ( ISBLANK( MobilePhone )),  AND( DoNotCall == FALSE, ISBLANK( Phone ) ),  FALSE  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>No number rule</fullName>
        <actions>
            <name>No_number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>rule for lead (NO number)</description>
        <formula>AND( DoNotCall == FALSE, ISBLANK( Phone  ) ,      ISBLANK( MobilePhone  ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
