public with sharing class XMLResponseClass {
	public void parseResponse(){

    String XMLResponse = '<ArrayOfMemberInformation>'+
	'<MemberInformation Imod_Member_Id="8" Constituent_Id="447" Last_Updated="2012-10-03T10:26:07" Last_Updated_By_Constituent_Id="589391" Last_Updated_By_Name="Jodi Briggs" From_Facebook="false">'+
		'<Column Name="spriden_pidm" Value="447"/>'+
		'<Column Name="kid_data" Value="Robert Fitzgerald;Kathleen Fitzgerald"/>'+
		'<Column Name="kid_count" Value="02"/>'+
	'</MemberInformation>'+
	'<MemberInformation Imod_Member_Id="41" Constituent_Id="1944" Last_Updated="2012-04-04T00:43:04" Last_Updated_By_Constituent_Id="1944" Last_Updated_By_Name="John Adams" From_Facebook="false">'+
		'<Column Name="spriden_pidm" Value="1944"/>'+
		'<Column Name="kid_data" Value="Jessica Adams (09);Brooke Adams (06)"/>'+
		'<Column Name="kid_count" Value="02"/>'+
	'</MemberInformation>'+
	'</ArrayOfMemberInformation>';
	
	List<Account> newaccounts = new List<Account> ();
       Dom.Document docx = new Dom.Document(); 
	   docx.load(XMLResponse);
	   dom.XmlNode xroot = docx.getrootelement() ;	   
	   dom.XmlNode [] xrec = xroot.getchildelements() ;
       system.debug('outside***');
	   for(Dom.XMLNode child : xrec)
	   {
	   		account accObj = new Account (); 
	   		for (dom.XmlNode element : child.getchildren())
	   		{
	   			system.debug('element***/n' + element);
                system.debug('element.getname()***' + element.getname());
	   			 if (element.getname() == 'Column') {
					system.debug('*****spriden_pidm' + element.gettext());
					accObj.Banner_PIDM_Id__c = element.gettext();

            	} 	   			
	 		}
	   }
	   //newaccounts.add(accObj);

	  
	}
	
}