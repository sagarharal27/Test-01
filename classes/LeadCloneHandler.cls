/**
  *Write a Trigger on  Lead which will create the clone record.
  */

public with sharing class LeadCloneHandler {
    // Constructor
    public LeadCloneHandler(List<Lead> leadParameter) {
        List<Lead> leadList= new List<Lead>();
        // Iterate over list of lead
        for (Lead listInstance : leadParameter) {
            leadList.add(listInstance.clone());
        }
        // Check list not empty
        if (!leadList.isEmpty()) {
            insert leadList;
        }
    }
}