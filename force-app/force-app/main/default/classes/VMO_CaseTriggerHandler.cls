/* Project Base VMO
 * Created Date: 24/07/2023
 * Created By: LocHN
 * Descript: VMO_CaseTriggerHandler
 * PIC: LocHN,Ducvv
*/
public with sharing class VMO_CaseTriggerHandler {
    public static Boolean checkUpdate = true; 
    //handler AfterUpdate functions
    public static void onAfterUpdate (List<Case> newCaseList, Map<Id, Case> oldCaseMap) {
        insertRecTicketHistory(newCaseList, oldCaseMap);
    }
    //handler AferInsert functions
    public static void onAfterInsert(List<Case> newCaseList) {
        completeSubject(newCaseList); 
    } 
    //handler BeforeUpdate functions
    public static void onBeforeUpdate(List<Case> newCaseList, Map<Id, Case> oldCaseMap) {
        preventSubjectUpdate(newCaseList, oldCaseMap);
    } 
    //handler BeforeInsert functions
    public static void onBeforeInsert(List<Case> newCaseList) {
        checkfieldSubject(newCaseList);
    }
    //completeSubject tự động cập nhật Subject: caseNumber+Subject
    private static void completeSubject(List<Case> newCaseList) {
        List<Case> caseListUpdate = new List<Case>(); 
        for (Case caseRec : newCaseList) {
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
    private static void checkfieldSubject(list<case> newCaseList) {
            for(case caseRec: newCaseList ) {
                //check field subject có null hay không
                if(String.isBlank(caseRec.Subject)) {
                    caseRec.Subject.addError(VMO_CommonConstant.SUBJECTNULL_ERROR_MESS);
                }
            }
        }
    //ngăn chặn không cho thay đổi subject khi complete
    private static void preventSubjectUpdate(List<Case> newCaseList, Map<Id, Case> oldCaseMap) {
        //check value cờ checkupdate có thay đổi giá trị có chạy qua compele hay chưa.
        if(checkUpdate){
            for(Case caseRec: newCaseList) {
                //check giá trị trước và sau của subject
                if(oldcaseMap.get(caseRec.Id).Subject != caseRec.Subject) {
                        caseRec.Subject.addError(VMO_CommonConstant.PREVENTSUBJECTUPDATE_ERROR_MESS);
                }
            }
        }
    }
    //field change thì create record TicketHistory
    private static void insertRecTicketHistory (List<Case> newCaseList, Map<Id, Case> oldCaseMap) {
        Set<Id> handlerIds = new Set<Id>();
            List<VMO_TicketHistory__c> targetTicketToAdd = new List<VMO_TicketHistory__c>();
                //gán giá trị vào handlerIds
                for (Case newCase : newCaseList) {
                    if(newCase.VMO_TicketHandler__c != oldCaseMap.get(newCase.Id).VMO_TicketHandler__c) {
                    handlerIds.add(oldCaseMap.get(newCase.Id).VMO_TicketHandler__c);
                    handlerIds.add(newCase.VMO_TicketHandler__c);
                    }
                }
                Map<Id, User> userMap = new Map<Id, User>(VMO_UserDAO.getFullName(handlerIds));
                for(String fieldName : VMO_CommonConstant.LISTFIELDNAMECASE_CHANGE) {
                    for (Case newCase : newCaseList) {
                        if((String) oldcaseMap.get(newCase.Id).get(fieldName) != (String) newCase.get(fieldName)) {
                            String oldVal = VMO_CommonConstant.CHAINNULL;
                            String newVal = VMO_CommonConstant.CHAINNULL;
                        //gán fullname vào old - new
                        if(fieldName == VMO_CommonConstant.FIELDNAMETICKET) {
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