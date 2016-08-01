public with sharing class Assignment10 {
    
    // Q1 ************************************************************************

    //  Method which will accept Integer as parameter 
    //  and determine & print the number is prime or not
        
    
    public boolean Prime(Integer num) {
         Integer n=num;
         Integer i=0;
        for(i=2;i<=num/2;i++) {
            if(Math.mod(num, i)==0) {
                System.debug(n + ' Not a prime number');
                return false;
            }
        }
        System.debug(n + ' Is a prime number');   
        return true;
    }
    
    /*
     Assignment10  a=new Assignment10();
     a.countLength(25);
     a.countLength(79);
     
     OUTPUT
     25 Not a prime number
    
     79 Is a prime number
    
    */
    
    // Q2 ************************************************************************

    // Check Palindrome or not
    
    
    
    public void palindrome(String sample) {
        if(sample.equalsIgnoreCase(sample.reverse())) {
            System.debug(sample+ ' is Palindrome');
        }
        else {
            System.debug(  sample + ' not a palindrome');
        }
    }
    
     /*
   
     Assignment10  a=new Assignment10();
     a.countLength('abab');
     a.countLength('abba');
     
     OUTPUT
     abab not a palindrome
    
     abba is Palindrome
    
    */
   
      
    
    //  Q3  ***************************************************************************
    
    //Replace every occourance
 
    
    public void replace() {
        String stringInstance='Google';
        List<Integer> listInteger=new  List<Integer>();
        listInteger=stringInstance.getChars();
        List<Integer> newStringInstance=new  List<Integer>();
        for(Integer i=0;i<listInteger.size();i++) {
            if(listInteger.get(i)==111)
            newStringInstance.add(97);
            else
            newStringInstance.add(listInteger.get(i));
        }
        String StringReplaced=String.fromCharArray(newStringInstance);
        System.debug(StringReplaced);
    }
    
     /*
   
        Assignment10  a=new Assignment10();
        a.replace();
       
        OUTPUT
       
        Gaagle
   
   
     */
   
   
   
   
    
    
    //  Q4  ****************************************************************************
  
    // Method to count the length of a string (not using length function)
    
    public void countLength(String sample) {
        List<Integer> l1 =sample.getChars();
        Integer i=0;
        for(Integer count : l1) {
            i++;
        }
        System.debug('Count is '+i);
    }
        
    /*
        OUTPUT
        
        Assignment10  a=new Assignment10();
        a.countLength('qwerty');
        Count is 6
        
    */
    
    
    
    
    //  Q5  ****************************************************************************
    
    // Method to find only the unique numbers in an array (accept array as a parameter) 
    // Hint:Use list and set
    
    public void unique() {
     list<Integer> a=new list <Integer>{8,9,9,9,3,1};
     list<Integer> b=new list <Integer>();
        for(Integer i=0;i<a.size();i++) {
            boolean x = false;
            for(Integer j=0;j<i;j++) {
                if(a[i] == a[j]) {
                    x = true;
                    break;
                }
            }
            if(!x){
                b.add(a[i]);
                System.debug(a[i]+' ');
            }
            System.debug(b +' ');
        }
    }
    
        /*
    
      Assignment10 a=new Assignment10();    
        a.unique();  
        
       OUTPUT
       
       (8, 9, 3, 1) 
    
    
    /*
    
        public void unique( ) {
            list<Integer> a=new list <Integer>{8,9,9,9,3,1};
            list<Integer> b=new list <Integer>();
            
            for(Integer i=0;i<a.size();i++) {
            system.debug('yoooooooooooooooooooooo');
               for(Integer j=1;j<a.size();j++) {
                   if(a[i] != a[j]) {
                       system.debug(i+'---------'+j);
                      b.add(a[i]);
                      break;
                   }
           }
           
           system.debug(''+b);  
       }
       
    }*/
}