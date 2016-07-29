public class record_name_withJohn {
    public void get_record(){
        
    List<Contact> conlist=[select Account.Name ,Account.Industry from Contact where  Account.Industry='media'];
        System.debug(conlist);
    }

}