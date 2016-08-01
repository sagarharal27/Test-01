// Static Example

global with sharing class StaticFunction { 
    global static Integer p=30;
    global static void testStatic() {
        p=p+10;
        System.debug(p);
        //return p;        
    }
}