public class odd_even {
   list<integer> l1 = new list<integer>{4,8,6,45,9,1};
       list<integer> l2 = new list<integer>();
     public void odd_even_method(Integer i){
         integer r= math.mod(i,2);
        if( r==0)
            system.debug(i+' Is Even number.');
        else
          system.debug(i+' Is Odd number.');              
    }     
     public void arrayofno(Integer n){
         list<integer> l1= new list<integer>();
         for(integer i=0; i<n; i++){
             l1.add(i);
         }
         system.debug(l1);
     }
    
    public void ascending_array(){
        system.debug('Before sorting ' + l1);
        l1.sort();
        system.debug('After sorting ' + l1);
    }
        public void decending_array(){
            for(integer i=0; i<l1.size(); i++ ){
                for(integer j=1; j<l1.size(); j++){
                    if(l1[j-1]<l1[j]){
                        integer temp=l1[j-1];
                        l1[j-1]=l1[j];
                        l1[j]=temp;
                    } 
                }
          }
            system.debug('Decending order: '+ l1);
        }
    public void max_no_ofarray(){
     integer large=l1[0];
     integer small=l1[0];
        for(integer i=1; i<l1.size(); i++){
            if(l1[i]>large)  
                large=l1[i];
                else if(l1[i]<small)
                    small=l1[i];
            
        }
        
        system.debug('maximum no:' + large );
        system.debug('minimum no:' + small );               
       }
    public void summation_ofarray(integer num1){
        integer sum=0,i=0;
        //for(i=0; i<num1; i++){
           // l2.add(i);
            for(i=0; i<=num1; i++){
               sum=sum+i;
            }
              system.debug('Sum of numbers:'+sum);  
            }
    public void simple_interest(decimal p,decimal n,decimal r){
        decimal si=(p*n*r)/100;
        system.debug('Simple interest is:'+ si);
    }
   
   }