<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>notification_to_the_Manager</fullName>
        <description>notification to the Manager</description>
        <protected>false</protected>
        <recipients>
            <recipient>pooja.jadhav@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SalesNewCustomerEmail</template>
    </alerts>
    <fieldUpdates>
        <fullName>current_employee</fullName>
        <description>assigns non technical if current employee is false</description>
        <field>RecordTypeId</field>
        <lookupValue>Non_Technical</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>current employee</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>rule_1</fullName>
        <field>Role_Name__c</field>
        <formula>Role_of_employee__r.Name</formula>
        <name>rule 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>If not current employee then change record type</fullName>
        <actions>
            <name>current_employee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employee__c.Current_Employee__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Assign to non technical if current emp is false</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification to manager on deactivation of record</fullName>
        <actions>
            <name>notification_to_the_Manager</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employee__c.Is_active__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>notify the Manager of the Employee once the record is deactivated</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>One employee should have one role</fullName>
        <actions>
            <name>rule_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>One employee should have only one role</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
