/************************************************************************
 Class Name: Aggregate_function
 Created Date:14/7/2015
 Description: This class performs an aggregate functions
*************************************************************************/ 
public class aggregateFunctions {
	//method to calculate sum of opp.record which are closed
    public void sumOfAllClosedOpportunity(){
        List<AggregateResult> aggreResult = [Select SUM(opp.Amount) sum,CloseDate 
                                             From Opportunity opp 
                                             where CloseDate = THIS_FISCAL_YEAR
                                             group by CloseDate];
        
        if(aggreResult!=NULL && aggreResult.size()>0){
            map<Integer,Double> mapYeartoSum = new map <Integer,Double>();
            for(AggregateResult alist : aggreResult){
                Date dateobj=Date.valueOf(alist.get('CloseDate'));
                Integer year=dateobj.year();
                Double amount = Double.valueOf(alist.get('sum'));
                mapYeartoSum.put(year,amount);
    		 }
    		system.debug(mapYeartoSum); 
  	 	}
        else{
            system.debug('Records not found');
        }
    }
   //method to display distinct Lead records on basis of 'Lead Source'having greater than 10 lead 
	public void AggregateLeadSource(){
	AggregateResult[] leadresults = [SELECT COUNT_DISTINCT(Name) , LeadSource
                                    FROM Lead
                                    Group By LeadSource
                                    Having COUNT_DISTINCT(Name) > 8 ]; 
    for(AggregateResult aggreobj : leadresults){
		System.debug(aggreobj);
     }
	}
   //method to display distinct Lead records on basis of 'Lead Source' 
	public void AggregateOfLeadRecord(){
		Aggregateresult[] aggreResult = [select count(Name),LeadSource
                                         from Lead
                                         group by LeadSource];
		for(AggregateResult aggobj:aggreResult){
			system.debug(aggobj);
         }
    }
    
    
}