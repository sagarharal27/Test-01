public with sharing class TrialController 
{
public Boolean con{get;set;}
public TrialController()
{
con = false;

}
public void tryial()
{
    system.debug('>>>>>>>>'+con);
}
}