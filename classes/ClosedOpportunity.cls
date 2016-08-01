public with sharing class ClosedOpportunity {
    public ClosedOpportunity() {
        // Aggregate Result on Opportunity
                List<AggregateResult> aggregateResult = [Select SUM(o.Amount) sum,CloseDate 
                                          From Opportunity o 
                                          group by CloseDate];
        
        map<Integer,Double> closedOpp = new map <Integer,Double>();
        for(AggregateResult resultInstance : aggregateResult) {
            
            Date dateInstance=Date.valueOf(resultInstance.get('CloseDate'));
            Integer year=dateInstance.year();
            Double amount = Double.valueOf(resultInstance.get('sum'));
            closedOpp.put(year,amount);
        }
        system.debug(closedOpp);   
    }
}


/*

{2015=6789877.0}

*/