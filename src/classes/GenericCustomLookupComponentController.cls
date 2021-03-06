/*
Author: Angel Robles (anyei)
Purpose : Controller for GenericCustomLookup visualforce component

*/
global class GenericCustomLookupComponentController {
   

    static Map<string,Schema.DescribesObjectResult> types {get;set;}
    public string textFieldPs {get;set;}
    public string CustomOrgPrefix  {get { string prfixWR = new PageReference('/apex/').getUrl(); if(prFixwR.contains('__')) return prFixwR.substringBefore('__').substringAfterLast('/')+'__'; else return '';  }}
    public string Text{get;set;}
    
    @remoteAction
    global static string getText(string vid){
   
   		    string result = '';         
            
            sobject o = null;
            string q= '';
            string pref = '';
            if(vid != null && vid != ''){
                
        		pref = vid.left(3);
                 types = new Map<string, Schema.DescribesObjectResult> ();
                Map<string, Schema.SobjectType> sobjectTypes = Schema.getGlobalDescribe();
                for(string k : sobjectTypes.keyset()){
                    Schema.DescribesObjectResult  dr = sobjectTypes.get(k).getDescribe();
                    string p =  dr.getKeyPrefix();
                    types.put(p,dr);
                }
                if(types.containsKey(pref)){
                     Schema.DescribesObjectResult soResult= types.get(pref);
               		 string oName = soResult.getLocalName();                    
                    q = 'select name from ' + oname + ' where id =\''+vid+'\'';
                    o = database.query(q);
                    result = string.valueof(o.get('name'));
                    
                }
            }   
   
        return result;
        
    }
                     
   
    public object valueid {get;set;}    
    
}
