/* Project Base VMO
 * Created Date: 14/08/2023
 * Created By: Ducvv
 * Descript: VMO_CaseDAO
 * PIC: Ducvv
*/
public with sharing class VMO_CaseDAO {
    public static Integer getCaseTickets() { 
        return [SELECT COUNT() 
                FROM Case];
   }
   public static Integer getCaseThisMonth() {
        return  [SELECT COUNT() 
                FROM Case 
                WHERE CreatedDate = THIS_MONTH];
   }

   public static Integer getCaseOpen() {
        return [SELECT COUNT()  
                FROM Case 
                WHERE Status = :VMO_CommonConstant.CHAIN_NEW]; 
   }
   public static Integer getCaseProcessing() {
        return [SELECT COUNT() 
                FROM Case 
                WHERE Status != :VMO_CommonConstant.CHAIN_NEW
                AND IsClosed = FALSE];
   }
   public static Integer getCaseClosed() {
        return [SELECT COUNT() 
                FROM Case 
                WHERE IsClosed = True ];
   }
   public static list<AggregateResult> getStatus() {
        List<AggregateResult> listCaseStatus  = new List<AggregateResult>();    
        listCaseStatus = [SELECT Status FROM Case GROUP BY Status];
        return listCaseStatus;
   }
   public static list<AggregateResult> getCategory() {
        List<AggregateResult> listCaseCategory  = new List<AggregateResult>();    
        listCaseCategory = [SELECT VMO_Category__c FROM Case GROUP BY VMO_Category__c];
        return listCaseCategory;
   }
   public static list<AggregateResult> getTicketType() {
        List<AggregateResult> listCaseTicketTpye  = new List<AggregateResult>();    
        listCaseTicketTpye = [SELECT VMO_TicketType__c FROM Case GROUP BY VMO_TicketType__c];
        return listCaseTicketTpye;
}
}