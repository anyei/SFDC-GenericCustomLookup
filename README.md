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
<apex:form>
</apex:pageBlockSection>
     <apex:pageblocksectionitem >
          <c:GenericCustomLookup ID="Product" 
                                      Label="Products" 
                                      Columns="Product2.Name,Product2.ProductCode,Product2.Id" 
                                      ColumnLabels="Family,Code,Id" 
                                      ActionColumn="Product2.Name" 
                                      SearchColumn="Product2.Name" 
                                      SObjectType="PricebookEntry" 
                                      ValueField="Product2.Id"                                  
                                      Filter="f1=Pricebook2id&fv1={!customObject__c.pricebookid__c}&f2=IsActive&fv2=true"
                                      ObjectProperty="{!customObject__c.Product__c}"                                      
                                 	  required="true"
                                 />
 </apex:pageblocksectionitem> 
</apex:pageBlockSection>

</apex:pageBlock>
</apex:form>
```


### TODO
1. Produce better documentation and guide
2. Review and clean code
