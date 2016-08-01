public with sharing class ActiveUsers {
    public ActiveUsers() {
        List<User> userList = [Select u.Username, u.LastLoginDate, u.Id, u.FirstName 
                               From User u 
                               where u.IsActive=TRUE];
        Map<Id,User> act = new Map<Id,User>();
        for(User auser: userList)
            act.put(auser.ID,auser);
        system.debug(act+'\r');
    }

}