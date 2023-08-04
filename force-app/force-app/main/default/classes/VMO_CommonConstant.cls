/* Project Base VMO
 * Created Date: 24/07/2023
 * Created By: LocHN
 * Descript: Common constant String
 * PIC: LocHN,Ducvv
*/
public with sharing class VMO_CommonConstant {
   
        public static String DEFAULT_ERROR_MESS = 'Intenal Error!';
        public static String CREATETICKET_SUCCESS = 'Ticket created successfully!';
        public static String CREATETICKET_FALSE = 'Create Ticket Failed: ';
        public static String SUBJECTNULL_ERROR_MESS = 'Please input Subject !';
        public static String PREVENTSUBJECTUPDATE_ERROR_MESS = 'Please input Subject !';
        public static List<String> LISTFIELDNAMECASE_CHANGE = new list<String> {'Status', 'OwnerId', 'VMO_Answer__c', 'VMO_TicketHandler__c'};
    
}