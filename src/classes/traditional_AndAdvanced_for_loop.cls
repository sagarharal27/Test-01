public class traditional_AndAdvanced_for_loop
{
   public void  display(){
   
       list<Account> list1 = [select id, accountnumber from Account];
       
       for(integer i=0; i<list1.size(); i++)
       {
           system.debug(list1[i]);
       }
       
       //for(Account acc: list1)
       //{system.debug(acc)}
   }
}