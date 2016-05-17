# SFDC-GenericCustomLookup
Custom Lookup Visualforce Component


### Install

##### Deploy to Salesforce Button

This will only work for sandboxes as no test class has been added to the repo so far.

<a href="https://githubsfdeploy.herokuapp.com?owner=anyei&repo=SFDC-GenericCustomLookup">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>

##### Manual Install

You may manually create the apex classes first within your org and then the visualforce page and the visual force component. 

### Usage
Just place the custom component under the "apex:form" tag, assign the require properties.

```
<apex:page standardController="CustomObject__c" >
    
    
    
    
       <c:GenericRelatedList Fields="Field1__c,Field2__c" 
                             Condition="RecordTypeId='Some_Specific_RecordTypeid' and CustoMObject__c='{!CustomObject__c.id}'" 
                             SObjectType="CustomObjectRelated__c" 
                             HeaderTitle="Related Records"></c:GenericRelatedList>

    
  
</apex:page>
```


### TODO
1. Produce better documentation and guide
2. Review and clean code
