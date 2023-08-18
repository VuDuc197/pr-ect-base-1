/* Project Base VMO
 * Created Date: 14/08/2023
 * Created By: Ducvv
 * Descript: VMO_CaseController
 * PIC: Ducvv
*/
public with sharing class vmo_CaseController {
    @AuraEnabled(cacheable = true)
    public static Integer getToTalTickets() {
        Integer ToTalTickets = VMO_CaseDAO.getCaseTickets();
        Return ToTalTickets;
    }
    @AuraEnabled(cacheable = true)
    public static Integer getToTalThisMonth() {
        Integer ToTalThisMonth = VMO_CaseDAO.getCaseThisMonth();
        Return ToTalThisMonth;
    }
    
    //count tổng số case thỏa mãn đk Case.Status = "New"
   @AuraEnabled(cacheable = true)
   public static Integer getToTalOpen() {
       Integer ToTalOpen = VMO_CaseDAO.getCaseOpen(); 
       return ToTalOpen;
   }
   //count tổng số case thỏa mãn đk Case.Status != "New" && Case.isClosed= false
   @AuraEnabled(cacheable = true)
   public static Integer getToTalProcessing() {
       Integer totalProcessing = VMO_CaseDAO.getCaseProcessing();
       return totalProcessing;
   }
   //count tổng số case thỏa mãn đk Case.isClosed= true
   @AuraEnabled(cacheable = true)
   public static Integer getToTalClosed() {
       Integer totalClosed= VMO_CaseDAO.getCaseClosed();
       return totalClosed;
    }
    @AuraEnabled(cacheable = true)
    public static List<AggregateResult> getStatusResult() {
       List<AggregateResult> listStatusResult = VMO_CaseDAO.getStatus();
        return listStatusResult;
    }
    @AuraEnabled(cacheable = true)
    public static List<AggregateResult> getCategoryResult() {
       List<AggregateResult> listCategoryResult = VMO_CaseDAO.getCategory();
        return listCategoryResult;
    }
    @AuraEnabled(cacheable = true)
    public static List<AggregateResult> getTicketTypeResult() {
       List<AggregateResult> listTicketTypeResult = VMO_CaseDAO.getTicketType();
        return listTicketTypeResult;
    }
}