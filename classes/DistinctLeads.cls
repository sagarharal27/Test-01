public class DistinctLeads {
    public DistinctLeads() {
        // Aggregate Result to count the distinct leads grouping by leadsource
        AggregateResult[] leadresults = [SELECT COUNT_DISTINCT(Name),LeadSource
                                         FROM Lead
                                         Group By LeadSource
                                         HAVING COUNT_DISTINCT(Name) > 4]; 
        // print the result of leads
        for(AggregateResult resultInstance : leadresults) {
             System.debug(resultInstance);
        }
    }
}


/*
OUTPUT

AggregateResult:{expr0=16, LeadSource=null}

AggregateResult:{expr0=14, LeadSource=Web}

AggregateResult:{expr0=100, LeadSource=Open - Not Contacted}

////////////////////////////////////////////////////////////
AggregateResult:{expr0=8, LeadSource=null}

AggregateResult:{expr0=106, LeadSource=Web}

AggregateResult:{expr0=40, LeadSource=Phone Inquiry}

AggregateResult:{expr0=67, LeadSource=Partner Referral}

AggregateResult:{expr0=50, LeadSource=Purchased List}

AggregateResult:{expr0=81, LeadSource=Other}

AggregateResult:{expr0=24, LeadSource=Phone}


////////////////////////////////////////////////////////////


AggregateResult:{expr0=8, LeadSource=null}

AggregateResult:{expr0=106, LeadSource=Web}

AggregateResult:{expr0=40, LeadSource=Phone Inquiry}

AggregateResult:{expr0=67, LeadSource=Partner Referral}

AggregateResult:{expr0=50, LeadSource=Purchased List}

AggregateResult:{expr0=81, LeadSource=Other}

AggregateResult:{expr0=2, LeadSource=Message}

AggregateResult:{expr0=24, LeadSource=Phone}


*/