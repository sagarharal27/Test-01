public class LeadInsert {
    public LeadInsert() {
        List<Lead> leadl = new List<Lead>(); 
        Integer j=0;
        while(j<2) {
            for(Integer i=0; i<5 ; i++) { 
                Lead listLead = new Lead(LastName='qwerty11'+i, Company='Test',
                                LeadSource='Open - Not Contacted', Unique_Field__c= 'abc11'+i);
                leadl.add(listLead);
                System.debug(leadl);
            }//for
            j++;
        }//while
      if((leadl.size()!= 0) ) {
            //partial insert
            Database.SaveResult[] srList = Database.insert(leadl,false);
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                }
                else {
                //Operation failed, so get all errors
                    for(Database.Error err : sr.getErrors()) {
                        Logs__c error =new Logs__c();
                        error.Name='Errrrroooorrrr';
                        error.Error__c=err.getMessage();
                        insert error;
                    }
                }
            }
         }
    }
}