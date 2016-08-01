public with sharing class Set2 
{
   
    
    
    
    
    //  Q3  ***************************************************************************
    
    //Replace every occourance
    /*
        public void replaceChar()
       {
            List<String> a=new List<String>();
            List<String> b=new List<String>();
            // aabbcc => aaxxcc
            String z;
            a.add('a');
            a.add('a');
            a.add('b');
            a.add('b');
            a.add('c');
            a.add('c');
            system.debug(+ a);
            //b=a.getchars();
            for(integer i=a.size()-1;i>=0;i--) {
                acntSaleDet.replace('Amount $', '<br>Amount $');
                
                z=a.get(a[i]);
                if(z=='bb') {
                    a.add(i,'xx');    
                }
            }
            system.debug(' : '+a);
          
       }
          
          /*
           String reverseString=String.fromCharArray(b);
           system.debug('Reverse of string is :'+reverseString);
            }
        
        
    }
        
        
        
          
          
          
         /*     
        System.debug(a);
        for(Integer i=a.size()-1;i<=0;i--)
        {
            x=a.getCharAt()
            
            b.add(a[i]);
                     
        }
        System.debug(b);
        
        /*
        String s=text1.replaceAll(char1,'q');String text1, String char1
        system.debug('Replaced String is : '+s);
        */
    
    
    
   
    
    //  Q5  ****************************************************************************
    
    // Method to find only the unique numbers in an array (accept array as a parameter) 
    // Hint:Use list and set
   
    public void unique( )
    {
        
        list<Integer> a=new list <Integer>{8,9,3,1,4,4};
        list<Integer> b=new list <Integer>();
        boolean x;
        Integer i,j;
        for(i=0;i<a.size();i++) {
            system.debug('CHECK8888888888888888888888888888888888888888888888888888888888888888888');
            x=true;
            for(j=0;j<b.size();j++) {
                system.debug('Replaced String is : 88844444444444444444444444444444444444444444444444444444448');
                if(a[i]==b[j]) {
                    x=false;
                    system.debug('111111111111111111111111111111111111111111111111111111111111888 ');
                    break;
                }
             }
            
                b[j]=a[i];
               
        }
        
     }
    
        
        
        
        /*
        list<Integer> a= new list<Integer>();
        list<Integer> b= new list<Integer>();
        
        for(Integer i=1;i<a.size();i++) {
            for(Integer j=0;j<b.size();i++){
                if(a[i]==b[j])
                    break;
            }
        }
        
        */
        
        /*
        if(l1 != NULL)
        {
            s1.addAll(l1);
            System.debug(s1);
        }
        else
            System.debug('List is empty');*/
       
        
}  //class