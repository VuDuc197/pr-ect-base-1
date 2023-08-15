/* Project Base VMO
 * Created Date: 14/08/2023
 * Created By: Ducvv
 * Descript: VMO_CaseController
 * PIC: Ducvv
*/
public with sharing class vmo_CaseController {
    // count tổng số Case 
    @AuraEnabled(cacheable = true)
    public static Integer getToTalTickets() { 
        Integer totalTickets = [SELECT COUNT() FROM Case];
        return totalTickets;
    }
    //count tổng số case trong tháng.
    @AuraEnabled(cacheable = true)
    public static Integer getToTalThisMonth() {
        Integer totalThisMonth = [SELECT COUNT() FROM Case WHERE CreatedDate = THIS_MONTH];
        return totalThisMonth;
    }
    //count tổng số case thỏa mãn đk Case.Status = "New"
    @AuraEnabled(cacheable = true)
    public static Integer getToTalOpen() {
        Integer ToTalOpen = [SELECT COUNT() 
                                    FROM Case 
                                    WHERE Status = 'New']; 
        return ToTalOpen;
    }
    //count tổng số case thỏa mãn đk Case.Status != "New" && Case.isClosed= false
    @AuraEnabled(cacheable = true)
    public static Integer getToTalProcessing() {
        Integer totalProcessing = [SELECT COUNT() 
                                    FROM Case 
                                    WHERE Status != 'New'
                                    AND IsClosed = FALSE];
        return totalProcessing;
    }
    //count tổng số case thỏa mãn đk Case.isClosed= true
    @AuraEnabled(cacheable = true)
    public static Integer getToTalClosed() {
        Integer totalClosed= [SELECT COUNT() 
                                    FROM Case 
                                    WHERE IsClosed = True ];
        return totalClosed;
    }
}