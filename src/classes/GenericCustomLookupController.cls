/**************************************
Author             : Angel Robles
Purpose            : Controller of the GenericCustomLookup visualforce page
Created Date       : 4/27/2016
Reviewed By        : Angel Robles                   
**************************************/
public class GenericCustomLookupController{

  
    public string LookupSObjectType {get;set;}
    public string objectLabel {get;set;}
    public string SearchQueryString {get; set;}    
    public string Caller{get;set;}  
    public string searchField {get;set;}
    public string actionField {get;set;}
    public Map<string,string> additionalFilters {get;set;}
    public string columnsToDisplay {get;set;}
    public string columnsLabels {get;set;}
    public string columnsReturned {get;set;}
    public Map<string,string> FieldsToDisplay {get;set;}
    public List<KeyWrapper> FieldKeys {get;set;}
    public list<string> columnsReturnedList{get;set;}
    public List<RecordWrapper> records {get;set;}
    
    public GenericCustomLookupController(){
         records = new List<RecordWrapper>();
         FieldsToDisplay = new Map<string,string>();
        columnsReturnedList = new List<string>();
        
         LookupSObjectType = ApexPages.currentPage().getParameters().get('type'); 
         Caller = ApexPages.currentPage().getParameters().get('caller'); 
         searchField = ApexPages.currentPage().getParameters().get('sf');
         actionField = ApexPages.currentPage().getParameters().get('af');
        
         columnsToDisplay =ApexPages.currentPage().getParameters().get('columns');
         columnsLabels = ApexPages.currentPage().getParameters().get('columnsL');
         columnsReturned = ApexPages.currentPage().getParameters().get('columnsR');
        
         string q = ApexPages.currentPage().getParameters().get('q');
         if(!string.isEmpty(q) && !string.isblank(q) && q != null)
                    SearchQueryString = ApexPages.currentPage().getParameters().get('q');
                
          additionalFilters = new Map<string,string>();
           for(integer i =0;i<10;i++)    {
                      string f = ApexPages.currentPage().getParameters().get('f'+string.valueof(i));
                      string v = ApexPages.currentPage().getParameters().get('fv'+string.valueof(i));
                        if(f != null && v != null && !string.isBlank(f) && !string.isEmpty(f) &&  !string.isBlank(v) && !string.isEmpty(v)){
                            additionalFilters.put(f,v);
                        }
           }
        
        
        
    
        if(columnsLabels == null || columnsLabels == ''){
            if(LookupSObjectType != null && LookupSObjectType != ''){
                Schema.SObjectType sType= Schema.getGlobalDescribe().get(LookupSObjectType);
                Schema.DescribesObjectResult result =stype.getDescribe();
                objectLabel = result.getLabel();
                Map<string,Schema.SObjectField> allFields = result.fields.getMap();
                
                for(string f : columnsToDisplay.split(',')){
                    if(allFields.containsKey(f)){
                        Schema.SObjectField fieldDefinition =allFields.get(f);
                        Schema.DescribeFieldResult fr =FieldDefinition.getDescribe();
                        
                        FieldsToDisplay.put(f,fr.getLabel());
                    }
                }
                
                FieldKeys = new List<KeyWrapper>();
                for(string s : FieldsToDisplay.keyset()){
                 KeyWrapper kw = new KeyWrapper();
                    kw.leftSide = s;
                    kw.RawColumnName = s;
                   FieldKeys.add(kw);
                }
            }
        }else{
            FieldKeys = new List<KeyWrapper>();
            
            List<string> colLabels = columnsLabels.split(',');
            List<string> ctd =columnsToDisplay.split(',');
            
            for(integer i=0;i< ctd.size();i++){
                KeyWrapper kw = new KeyWrapper();
                kw.rawColumnName = ctd[i];
                if(ctd[i].contains('.')){
                   List<string> leftAndRight = ctd[i].split('\\.');
                    kw.leftSide=leftAndRight[0];
                    kw.rightSide =leftAndRight[1];                    
                    kw.isReference = true;                   
                }else
                  kw.leftSide = ctd[i];
                 FieldKeys.add(kw);
                
                FieldsToDisplay.put(ctd[i],colLabels[i]);
            }
        }
        
        if(columnsReturned != null && columnsReturned != ''){
            for(string s : columnsReturned.split(',')){
                columnsReturnedList.add(s);
            }
        }
        if(columnsReturnedList.size() <=0){            
            columnsReturnedList = new List<string>();
            for(integer i=0;i<FieldKeys.size();i++)
                columnsReturnedList.add(fieldKeys[i].leftside);
        }
        
        
        if(FieldKeys.size() > 0)
             getResults();
     }
             

    
    void getResults(){
    
         
        
        string additionalFiltersString = '';
        if(additionalFilters.size() > 0){
            for(string s:additionalFilters.keySet()){
                string valueType = 'string';
                try{
                    set<string> booleans = new set<string> {'true','false'};
                   if(booleans.contains(additionalFilters.get(s).tolowercase()))
                      valueType = 'bool';
                }catCh(exception e){}
                if(valueType == 'bool')
                    additionalFiltersString += ' and ' + s + ' = '+additionalFilters.get(s);
                else
                additionalFiltersString += ' and ' + s + ' = \''+additionalFilters.get(s)+'\''; 
            }            
        }
        
         
              string s = SearchQueryString;
                  if(s== null || s== '')
                     s= '%'; 
                  else                 
                      s= s.replace('*','%');
               s=s.replace('\'','');       
              
        string qs = 'select ' +columnsToDisplay + ' from '+ LookupSObjectType + ' where ('+ searchField + ' like \'%'+s+'%\' )  ' + (additionalFilters.size() > 0 ? additionalFiltersString : '') + ' limit 1000';
        
       records.clear();
        for(Sobject o : (List<sobject>)database.query(qs)){            
            records.add(new RecordWrapper(System.JSON.serialize(o), o));
        }
              
             
    }
    
    public PageReference doSearch(){
        getResults();
        return null;
    }
    
    public class RecordWrapper{
        public string jsonObj{get;set;}
        public sobject record {get;set;}
        
        public RecordWrapper(string jsonData, sobject rec){
            this.record = rec;
            this.jsonObj = jsonData;
        }
    }
    
    public class KeyWrapper{
        public string rightSide {get;set;}
        public boolean isReference {get;set;}
        public string leftSide {get;set;}
        public string rawColumnName {get;set;}
    }
      
}