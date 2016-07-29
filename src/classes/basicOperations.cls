/************************************************************************
 Class Name: basicOperationOnList
 Created Date:11/7/2015
 Description: This class performs basic operation on list
*************************************************************************/  
public class basicOperations {
    string strAscAction = 'asc';
    string strDscAction = 'dsc';
    string strMaxAction = 'max';
    string strMinAction = 'min';
    
	list<integer> listarray = new list<integer>();
   
     //method for displaying Ascending, dscending,maximum,minimum no of array
    public void operationsOnArray(list<integer> listArray, string operation){     
		 //Ascending order       
		if(operation.equalsIgnoreCase(strAscAction)){
            system.debug('Before sorting ' + listarray);
			listarray.sort();
			system.debug('After sorting ' + listarray); 
        }
        //Dscending order
		else if(operation.equalsIgnoreCase(strDscAction)){
            for(integer i=0; i<listarray.size(); i++ ){
			for(integer j=1; j<listarray.size(); j++){
				if(listarray[j-1]<listarray[j]){
					integer temp=listarray[j-1];
					listarray[j-1]=listarray[j];
					listarray[j]=temp;
                    } 
                }
          }
         //Maximum number
		system.debug('Decending order: '+ listarray);
        }
        else if(operation.equalsIgnoreCase(strMaxAction)){
            integer large=listarray[0];
			for(integer i=1; i<listarray.size(); i++){
				if(listarray[i]>large)  
				large=listarray[i];
			}      
         system.debug('maximum no:' + large );
		}
        //Minimum number
        else if(operation.equalsIgnoreCase(strMinAction)){
           integer small=listarray[0];
           for(integer i=1; i<listarray.size(); i++){
           if(listarray[i]<small)
               small=listarray[i];
           }
           system.debug('minimum no:' + small ); 
    }
    }
    //finding whether the no is odd or even   
	public void oddEvenMethod(Integer i){
        if(i<0)
        {system.debug('please enter possitive number');}
        else{
		integer r= math.mod(i,2);
			if( r==0)
				system.debug(i+' Is Even number.');
			else
				system.debug(i+' Is Odd number.');    
		}
    }
    
    // printing an array upto particular integer
	public void printingArray(Integer n){
		list<integer> listarray= new list<integer>();
			for(integer i=0; i<n; i++){
				listarray.add(i);
         }
		system.debug(listarray + 'Array ::' + listarray.size());
     }
    
	//Calculating sum of integer in array
	public void summationOfArray(integer num1){
		integer sum=0,i=0;
			for(i=0; i<=num1; i++){
				sum=sum+i;
            }
			system.debug('Sum of numbers:'+sum);  
	}
    
    //Calculating simple interest
	public void calculateSimpleInterest(integer p,integer n,integer r){
		decimal si=(p*n*r)/100;
		system.debug('Simple interest is:'+ si);
    }
}