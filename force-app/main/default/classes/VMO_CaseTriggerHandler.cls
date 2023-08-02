/* Project Base VMO
 * Created Date: 24/07/2023
 * Created By: LocHN
 * Descript: VMO_CaseTriggerHandler
 * PIC: LocHN,Ducvv
*/
public with sharing class VMO_CaseTriggerHandler {
    public static Boolean checkUpdate = true; 
        //handler AfferInsert functions
	public static void onAfterInsert(List<Case> caseList){
        completeSubject(caseList); 
	} 
    //handler BeforeUpdate functions
	public static void onBeforeUpdate(List<Case> caseList, Map<Id,Case> caseMap){
        preventSubjectUpdate(caseList, caseMap);
    } 
    //handler BeforeInsert functions
	public static void onBeforeInsert(List<Case> caseList){
        checkfieldSubject(caseList);
	}
    //completeSubject tự động cập nhật Subject: caseNumber+Subject
      private static void completeSubject(List<Case> caseList){
        List<Case> caseListUpdate = new List<Case>(); 
        for (Case caseRec : caseList) {
            Case newCase = new Case();
            newCase.Id = caseRec.Id;
            //gán giá trị subject mới 
            newCase.Subject = '[ '+caseRec.CaseNumber+' ]' +'+'+ '{ '+caseRec.Subject+' }';
                //update tạm thời vào bộ nhớ chưa đẩy vào database
                caseListUpdate.add(newCase);
            }
            //gán lại giá trị của cờ khi đã chạy complete
        checkUpdate = false;
            //update list vào data base.
        update caseListUpdate;    
    } 
    //check subject và message yêu cầu nhập subject
    private static void checkfieldSubject(list<case> caseList){
        for(case caseRec: caseList ){
            //check field subject có null hay không
          if(String.isBlank(caseRec.Subject)){
                caseRec.Subject.addError(VMO_CommonConstant.SUBJECTNULL_ERROR_MESS);
          }
        }
    }
    //ngăn chặn không cho thay đổi subject khi complete
    private static void preventSubjectUpdate(List<Case> caseList,Map<Id,Case> caseMap){
        //check value cờ checkupdate có thay đổi giá trị có chạy qua compele hay chưa.
        if(checkUpdate){
            for(Case caseRec: caseList){
                //check giá trị trước và sau của subject
                if(caseMap.get(caseRec.Id).Subject != caseRec.Subject){
                        caseRec.Subject.addError(VMO_CommonConstant.PREVENTSUBJECTUPDATE_ERROR_MESS);
                }
            }
        }
    }
}  