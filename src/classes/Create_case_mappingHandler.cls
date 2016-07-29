/************************************************************************
 Class Name: Create_case_mappingHandler
 Created Date:20/7/2015
 Description: This Handler class performs automatic case creation 
*************************************************************************/  
public with sharing class Create_case_mappingHandler {

    public static boolean stop = false;
        //Creating case
        public static void createCase(List <EFT_Transaction_Status__c > EFTList){
            //List of EFT Object's records

            //map of id of SalesHeader and record
            map<id,SalesHeader__c> SalesHeaderMap = new map<id,SalesHeader__c>();
            //set of ids of SalesHeader
            Set<id> SalesHeaderIds = new Set<id>();

            for(EFT_Transaction_Status__c EFTobj : EFTList){
                //Adding SalesHeader's id to set
                SalesHeaderIds.add(EFTobj.SalesLookup__c);
            }
            
            //retriving salesheader records for ids that have EFT lookup i.e. are in SalesHeaderIds
            List<SalesHeader__c> SalesHeaderRecordList = [SELECT id,
                                                          Status__c,Name,
                                                          AccountLookup__c,
                                                          Contactlookup__c,
                                                          (Select Id From EFT_Transaction_Status__r)
                                                          FROM SalesHeader__c
                                                          WHERE id IN: SalesHeaderIds];
            //maping salesheader obj to respective EFT ids 
            for(SalesHeader__c salesObject :SalesHeaderRecordList) {
                
                for(EFT_Transaction_Status__c eftObject :salesObject.EFT_Transaction_Status__r) {
                     
                     SalesHeaderMap.put(eftObject.id, salesObject);
                }
            }
            
            List<Case> caselist =new List<Case>();    
                for(EFT_Transaction_Status__c EFTinstance : EFTList) { 
                    SalesHeader__c ObjectToHoldSales =new SalesHeader__c();
                     ObjectToHoldSales=SalesHeaderMap.get(EFTinstance.id);
                    //checking conditions
                    if(EFTinstance.Method_Name__c == Constants.strMethodNameEFT) {

                        if(EFTinstance.Transaction_Status__c == Constants.strTransactionStatusEFT) {
                            system.debug('after status declined+++++++++++++++++++++++++');

                            if(ObjectToHoldSales.Status__c == Constants.strStatusSalesHeader ) {
                                     
                                Case caseObj= new Case();
                            
                                //assigning values to Case record
                                caseObj.AccountId = ObjectToHoldSales.AccountLookup__c;
                                caseObj.ContactId = ObjectToHoldSales.Contactlookup__c;
                                caseObj.Origin = Constants.strOriginCase;
                                caseObj.Reason = Constants.strReasonCase; 
                                caseObj.Priority = Constants.strPriorityCase;
                                caseObj.Status = Constants.strStatusCase; 
                                caseObj.Subject= caseobj.Account.Name +Constants.strSubjectNameCase +caseobj.Type;
                                caseObj.Open_Sales_Order__c= ObjectToHoldSales.Name;
                                caseObj.Transaction_status__c=EFTinstance.Transaction_Status__c;
                                caseObj.Sales_order_name__c= ObjectToHoldSales.Id;
                          
                                caselist.add(caseObj); 
                           
                             }
                         }
                     }
                }
            System.debug('Fuction Operating...');  
            if(!stop) {
                stop=true;
                insert caselist;
               
            }
        }
 }