/* Project Base VMO
 * Created Date: 24/07/2023
 * Created By: LocHN
 * Descript: VMO_CaseTriggerHandler
 * PIC: LocHN,Ducvv
*/
public with sharing class VMO_CaseTriggerHandler {
    public static Boolean checkUpdate = true; 
    //handler AffterUpdate functions
    public static void onAfterUpdate (List<Case> newcaseList, Map<Id, Case> oldcaseMap) {
        insertRecTicketHistory(newcaseList, oldcaseMap);
    }
    //handler AfferInsert functions
    public static void onAfterInsert(List<Case> newcaseList) {
        completeSubject(newcaseList); 
    } 
    //handler BeforeUpdate functions
    public static void onBeforeUpdate(List<Case> newcaseList, Map<Id, Case> oldcaseMap) {
        preventSubjectUpdate(newcaseList, oldcaseMap);
    } 
    //handler BeforeInsert functions
    public static void onBeforeInsert(List<Case> newcaseList) {
        checkfieldSubject(newcaseList);
    }
    //completeSubject tự động cập nhật Subject: caseNumber+Subject
    private static void completeSubject(List<Case> newcaseList) {
        List<Case> caseListUpdate = new List<Case>(); 
        for (Case caseRec : newcaseList) {
            Case newCase = new Case();
            newCase.Id = caseRec.Id;
            //gán giá trị subject mới 
            newCase.Subject = '['+caseRec.CaseNumber+']' +'+'+caseRec.Subject;
                //update tạm thời vào bộ nhớ chưa đẩy vào database
                caseListUpdate.add(newCase);
            }
            //gán lại giá trị của cờ khi đã chạy complete
        checkUpdate = false;
            //update list vào data base.
        update caseListUpdate;    
    } 
    //check subject và message yêu cầu nhập subject
    private static void checkfieldSubject(list<case> newcaseList) {
            for(case caseRec: newcaseList ) {
                //check field subject có null hay không
                if(String.isBlank(caseRec.Subject)) {
                    caseRec.Subject.addError(VMO_CommonConstant.SUBJECTNULL_ERROR_MESS);
                }
            }
        }
    //ngăn chặn không cho thay đổi subject khi complete
    private static void preventSubjectUpdate(List<Case> newcaseList, Map<Id, Case> oldcaseMap) {
        //check value cờ checkupdate có thay đổi giá trị có chạy qua compele hay chưa.
        if(checkUpdate){
            for(Case caseRec: newcaseList) {
                //check giá trị trước và sau của subject
                if(oldcaseMap.get(caseRec.Id).Subject != caseRec.Subject) {
                        caseRec.Subject.addError(VMO_CommonConstant.PREVENTSUBJECTUPDATE_ERROR_MESS);
                }
            }
        }
    }
    //field change thì create record TicketHistory
    private static void insertRecTicketHistory (List<Case> newcaseList, Map<Id, Case> oldcaseMap) {
        Set<Id> handlerIds = new Set<Id>();
            List<VMO_TicketHistory__c> targetTicketToAdd = new List<VMO_TicketHistory__c>();
                //gán giá trị vào handlerIds
                for (Case newCase : newcaseList) {
                    if(newCase.VMO_TicketHandler__c != oldcaseMap.get(newCase.Id).VMO_TicketHandler__c) {
                        handlerIds.add(oldcaseMap.get(newCase.Id).VMO_TicketHandler__c);
                        handlerIds.add(newCase.VMO_TicketHandler__c);
                    }
                }
                Map<Id, User> userMap = new Map<Id, User>([SELECT Id, Name FROM User WHERE Id IN :handlerIds]);
                for(String fieldName : VMO_CommonConstant.LISTFIELDNAMECASE_CHANGE) {
                    for (Case newCase : newcaseList) {
                        if((String) oldcaseMap.get(newCase.Id).get(fieldName) != (String) newCase.get(fieldName)) {
                            String oldVal = '';
                            String newVal = '';
                        //gán fullname vào old - new
                        if(fieldName == 'VMO_TicketHandler__c') {
                            oldVal = userMap.get(oldcaseMap.get(newCase.Id).VMO_TicketHandler__c)?.Name;
                            newVal = userMap.get(newCase.VMO_TicketHandler__c)?.Name;
                        } else {
                            oldVal = (String) oldcaseMap.get(newCase.Id).get(fieldName);
                            newVal = (String) newCase.get(fieldName);
                            }
                        //add rec vào list
                        targetTicketToAdd.add(new VMO_TicketHistory__c(
                            VMO_FieldName__c = fieldName,
                            VMO_OldValue__c = oldVal,
                            VMO_NewValue__c = newVal,
                            VMO_ChangedTime__c = newCase.LastModifiedDate,
                            VMO_RelatedTicket__c = newCase.Id,
                            VMO_ChangedUser__c = newCase.LastModifiedById
                        ));
                        }
                    }
             } 
        Insert targetTicketToAdd;
    }
}  