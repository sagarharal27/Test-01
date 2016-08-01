public class aeTextSearchController {
    
    public boolean firstPanel{get;set;}
    public boolean secondPanel{get;set;}
    public boolean thirdPanel{get;set;}

    public class conHelper{
        public String name {get; set;}
        public String email {get; set;}
    }
    
    public List<Contact> conList{get;set;}
    public List<User> userList{get;set;}
    public List<conHelper> conHList{get;set;}
    
      
    public String searchStr{get;set;}
     
    public aeTextSearchController () {
    firstPanel = false;
    secondPanel = false;
    thirdPanel = false;
    }
      
    public void soslDemo_method() {
      firstPanel = true;
    secondPanel = true;
    thirdPanel = true;

       conList = New List<Contact>();
       userList = New List<User>();
       conHList = New List<conHelper>();
       
       if(searchStr.length() > 1){
            String searchStr1 = '*'+searchStr+'*';
            String searchQuery = 'FIND \'' + searchStr1 + '\' IN ALL FIELDS RETURNING  User(Id,Name), Contact(name,email)';
            List<List <sObject>> searchList = search.query(searchQuery);
            userList = ((List<User>)searchList[0]);
            conList  = ((List<Contact>)searchList[1]);
            
            for(Contact c : conList){
                conHelper ch = new conHelper();
                ch.name = c.name;
                ch.email = c.email;
                System.debug(ch);
                conHList.add(ch);
            }
            System.debug(conHList);
            if(userList.size() == 0 && conList.size() == 0){
               apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Sory, no results returned with matching string..'));
               return;
            }
        }
       else{
           apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'Please enter at least two characters..'));
           return;
       }
    }
}