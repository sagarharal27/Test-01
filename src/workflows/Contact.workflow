<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>To_change_account_status</fullName>
        <field>Account_status__c</field>
        <formula>&quot;Closed&quot;</formula>
        <name>To change account status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>To change account status</fullName>
        <actions>
            <name>To_change_account_status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Is_account_open__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Changes account status from open to close</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
