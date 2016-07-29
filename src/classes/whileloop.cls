/************************************************************************
 Class Name: whileloop
 Created Date:11/7/2015
 Description: This class uses while loop to diplay Account record
*************************************************************************/  
public class whileloop {
    //method to display account list
    public void diplayingListUsingWhileLoop(){
        
        list<Account> list1 = [select id, accountnumber,Rating from Account];
        integer i=0;
        integer no=list1.size();
         while(no!=0)
         {
			system.debug('Id:'+list1[i].id+'Name:'+list1[i].accountnumber);
        	i++; 
            no--;
    }
}
}