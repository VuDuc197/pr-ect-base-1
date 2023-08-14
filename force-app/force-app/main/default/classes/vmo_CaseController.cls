/* Project Base VMO
 * Created Date: 14/08/2023
 * Created By: Ducvv
 * Descript: VMO_CaseController
 * PIC: Ducvv
*/
public with sharing class vmo_CaseController {
    @AuraEnabled(cacheable=true)
    public static Integer handleTotalTickets() {
        Integer totalTickets  = [SELECT COUNT(Id) FROM Case];
        return totalTickets;
    }
    @AuraEnabled(cacheable=true)
    public static Integer handleToTalThisMoth() {
        Integer totalThisMonth = [SELECT COUNT(Id) FROM Case WHERE CreatedDate IN (THIS_MONTH)];
        return totalThisMonth;
    }
    @AuraEnabled(cacheable=true)
    public static Integer handleToTalOpen() {
        Integer ToTalOpen = [SELECT COUNT(Id) FROM Case WHERE Status IN ('New')];
        return ToTalOpen;
    }
    @AuraEnabled(cacheable=true)
    public static Integer handleToTalProcessing() {
        Integer totalProcessing = [SELECT COUNT(Id) FROM Case WHERE Status NOT IN ('new')];
        return totalProcessing;
    }
    @AuraEnabled(cacheable=true)
    public static Integer handleToTalClosed() {
        Integer totalClosed= [SELECT COUNT(Id) FROM Case WHERE Status IN ('')];
        return totalClosed;
    }
}