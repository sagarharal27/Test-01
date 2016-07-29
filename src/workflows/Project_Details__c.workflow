<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Calendar_task_for_the_Project</fullName>
        <description>Calendar task for the Project</description>
        <protected>false</protected>
        <recipients>
            <recipient>pooja.jadhav@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MarketingProductInquiryResponse</template>
    </alerts>
    <alerts>
        <fullName>Remind_the_Project_Manager</fullName>
        <description>Remind the Project Manager</description>
        <protected>false</protected>
        <recipients>
            <recipient>pooja.jadhav@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SalesNewCustomerEmail</template>
    </alerts>
    <alerts>
        <fullName>Remind_thei_Project_Manager</fullName>
        <description>Remind the Project Manager</description>
        <protected>false</protected>
        <recipients>
            <recipient>pooja.jadhav@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Reminder_of_End_date</template>
    </alerts>
    <fieldUpdates>
        <fullName>open_to_close</fullName>
        <description>Status will change from open to close</description>
        <field>Status__c</field>
        <literalValue>CLOSE</literalValue>
        <name>open to close</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Calendar task for the Project</fullName>
        <actions>
            <name>Calendar_task_for_the_Project</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>task_of_workflow</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Send a notification email when new project is created</description>
        <formula>True</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Remind the Project Manager about end date</fullName>
        <active>true</active>
        <description>It reminds the Project Manager about the end date of the project 5 days prior.</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Remind_thei_Project_Manager</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Project_Details__c.End_Date__c</offsetFromField>
            <timeLength>-5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Today is  the End date of the project</fullName>
        <actions>
            <name>open_to_close</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Close the project if end date is today</description>
        <formula>TODAY()  =  End_Date__c = True</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>task_of_workflow</fullName>
        <assignedTo>pooja.jadhav@eternussolutions.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Project_Details__c.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>task of workflow</subject>
    </tasks>
</Workflow>
