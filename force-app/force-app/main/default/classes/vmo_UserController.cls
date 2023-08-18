/* Project Base VMO
 * Created Date: 17/08/2023
 * Created By: Ducvv
 * Descript: 
 * PIC: ducvv
*/
public with sharing class vmo_UserController {
    @AuraEnabled(cacheable=true)
    public static User getUserInfo() {
        User targetUsr = VMO_UserDAO.getUserAllInfo();
         system.debug('targetUsr' + targetUsr);
         return targetUsr;
    }
}