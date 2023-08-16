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

}