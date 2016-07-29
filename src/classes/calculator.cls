/************************************************************************
 Class Name: calculator
 Created Date:11/7/2015
 Description: This class performs four maths functions
*************************************************************************/ 
public class calculator {
    integer result;
    
    public void functionsOfCalculator(string operation,integer a,integer b)
    {      
        system.debug('operations: SUM SUB MUL DIV');
        //function for addition
        if(operation =='SUM'){
            result=a+b;
            system.debug('Your choice is SUM');
            system.debug('Result=' +result);
        }
        //function for substraction
        else if(operation =='SUB'){
            result=a-b;
             system.debug('Your choice is SUB');
            system.debug('Result=' +result);
        }
         //function for multiplication
        else if(operation =='MUL'){
            result=a*b;
             system.debug('Your choice is MUL');
            system.debug('Result=' +result);
        }
         //function for Division
         else if(operation =='DIV'){
            result=a/b;
             system.debug('Your choice is DIV');
            system.debug('Result=' +result);
        }
    }
}