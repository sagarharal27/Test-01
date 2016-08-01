/**
 *Write a SOQL query to find total number of Lead records by status by Lead Source. 
 * Store this information in map and display the same.
 *(Hint: map<string,map<string,integer>>)
 */

public with sharing class MapOfMap {
    // Constructor
    public MapOfMap() {
        List <AggregateResult> leadResult=[SELECT COUNT(Name) Countname , Status,LeadSource 
                                FROM Lead
                                GROUP BY LeadSource,Status];
        // Inner map
        map<String,Integer> m2=new map<String,Integer>();
        // Outter map
        map<String,map<String,Integer>> m1=new map<String,map<String,Integer>>();
        
        /*
        String a = ar.String.ValueOf.get('Status');
        String b = ar.String.ValueOf.get('LeadSource');
        String c = ar.String.ValueOf.get('CountName');
        
        system.debug(a);
        system.debug(b);
        system.debug(c);
        
        */
        
        // Iterate over aggregate result
        for(AggregateResult leadInstance : leadResult) {
            // Check if key exist  NO>>EXCUTE
            if(!m1.ContainsKey(String.ValueOf(leadInstance.get('Status')))) {
                m1.put(String.ValueOf(leadInstance.get('Status')),
                    new map<String,Integer>{String.ValueOf(leadInstance.get('LeadSource')) 
                                            => Integer.ValueOf(leadInstance.get('Countname'))});
            }
            // If key exist  YES>>EXCUTE
            else {
                m1.get(String.valueOf(leadInstance.get('Status'))).
                    put(String.valueOf(leadInstance.get('LeadSource')), 
                        Integer.valueOf(leadInstance.get('Countname')));
            }
            /*
            else {
                m1.get((String.ValueOf(leadInstance.get('Status')).
                    put(String.ValueOf(leadInstance.get('LeadSource')),
                        Integer.ValueOf(leadInstance.get('Countname')))));
            }
            */
        }
        System.debug(m1);
    }
}