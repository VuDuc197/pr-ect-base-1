/* Project Base VMO
 * Created Date: 17/08/2023
 * Created By: Ducvv
 * Descript: 
 * PIC: ducvv
*/
public with sharing class vmo_UserController {
    @AuraEnabled(cacheable=true)
    public static List<User> getUserInfor() {
        List<User> targetUsr = new List<User>();
         targetUsr =  VMO_UserDAO.getUserAllInfor();
         return targetUsr;
    }
}