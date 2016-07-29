public class Account_record_created_date_Today 
{
    public void display_account(){
    list <Account> listacc= [select id,name from Account ];
        system.debug(listacc);
    }
}