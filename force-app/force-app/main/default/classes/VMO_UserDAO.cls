/* Project Base VMO
 * Created Date: 24/07/2023
 * Created By: LocHN
 * Descript: Data Access Object to query from User object
 * PIC: LocHN
*/
public with sharing class VMO_UserDAO {
        // get current user information
        public static User getUserInfo(Id usrID) {
            List<User> usrQuery = [SELECT Id, 
                                   Department,
                                   Email,
                                   Name,
                                   Title,
                                   FullPhotoUrl,
                                   CompanyName
                                   
                                   FROM User 
                                   WHERE Id =: Userinfo.getUserid()];
            return usrQuery.size() > 0 ? usrQuery[0] : null;
    }
       public static List<User> getFullName(Set<Id> handerIds) {
            return [SELECT Id,
                                    Name 
                                    FROM User 
                                    WHERE Id 
                                    IN :handerIds];
        }
        public static User getUserAllInfo() {
                system.debug('ID : ' +  UserInfo.getUserId());
               return [SELECT Id, Name, VMO_StaffCode__c, VMO_BirthDate__c, FullPhotoUrl, Email, Title 
                                FROM User 
                                WHERE Id =: UserInfo.getUserId()];

     }
}