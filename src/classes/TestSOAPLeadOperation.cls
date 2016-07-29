@isTest
public class TestSOAPLeadOperation {

    static List<Lead> listLead = new List<Lead>() ;
    static List<Lead> leadListCheck = new List<Lead>() ;
    
    static testMethod void creationOfLead() {
        listLead = TestDatafactory.leadData(10);
        insert listLead;
        SOAPServiceOfLead.createNewLead('Pooja','Jadhav','Open - Not Contacted',
                                        'Eternus','pooja@gmail.com','1111111' );
         
        leadListCheck = [select id from Lead];
        System.assertEquals(11,leadListCheck.size());
    }
    static testMethod void creationFailOfLead() {
        listLead = TestDatafactory.leadData(10);
        insert listLead;
        SOAPServiceOfLead.createNewLead('Pooja','','Open - Not Contacted',
                                        'Eternus','pooja.com','1111111' );
         
        leadListCheck = [select id from Lead];
        System.assertEquals(10,leadListCheck.size());
    }
    static testMethod void deletionOfLead() {
        listLead = TestDatafactory.leadData(10);
        insert listLead;
        SOAPServiceOfLead.deleteLead('TestFirst','TestLast1',
                                     'p@eternussolutions.com','11111112' );
         
        leadListCheck = [select id from Lead];
        System.assertEquals(9,leadListCheck.size());
    }
    static testMethod void deletionFailOfLead() {
        listLead = TestDatafactory.leadData(10);
        insert listLead;
        SOAPServiceOfLead.deleteLead('TestFirst','',
                                     'p@com','11111112' );
         
        leadListCheck = [select id from Lead];
        System.assertEquals(10,leadListCheck.size());
    }
    static testMethod void updationOfLead() {
        listLead = TestDatafactory.leadData(10);
        insert listLead;
        SOAPServiceOfLead.updateLead('TestFirst','TestLast1',
                                     'p@gmail.com','999999' );
         
        leadListCheck = [select id from Lead where Email = :'p@gmail.com'];
        System.assertEquals(1,leadListCheck.size());
    }
    static testMethod void updationFailOfLead() {
        listLead = TestDatafactory.leadData(10);
        insert listLead;
        SOAPServiceOfLead.updateLead('TestFirst','',
                                     'p2gmail.com','99asdf9999' );
         
        leadListCheck = [select id from Lead where Email = :'p2gmail.com' ];
        System.assertEquals(0,leadListCheck.size());
    }
}