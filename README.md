# SFDC-GenericCustomLookup
Custom Lookup Visualforce Component

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
