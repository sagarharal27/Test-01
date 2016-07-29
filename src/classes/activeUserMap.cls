/************************************************************************
 Class Name: active_user_map
 Created Date:14/7/2015
 Description: performs map on account findind active user
*************************************************************************/ 
public with sharing class activeUserMap {
    //selecting active users
	public void active_user(){
		list<user> listuser= [select Id,Username from user where IsActive=TRUE];
        
        if(listuser!=null && listuser.size()>0){
		map<Id,User> activeuser=new map<Id,User>();
            for(User userobj:listuser){
				activeuser.put(userobj.Id,userobj);
            }
			system.debug(activeuser);
        }
        else{
            system.debug('Records not found');
        }
	}
}