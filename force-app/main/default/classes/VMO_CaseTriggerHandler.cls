public with sharing class VMO_CaseTriggerHandler {
    public static Boolean checkUpdate = true; 
    public VMO_CaseTriggerHandler() {
    }
	public static void onAfterUpdate(List<Case> caseList, Map<Id,Case> caseMap){
        System.debug('AfterUpdate caseLits : '+caseList);
        System.debug('AfterUpdate caseMap : '+caseMap);
            
    } 

	public static void onAfterInsert(List<Case> caseList){
        System.debug('AfterInsert caseList : '+caseList);
        completeSubject(caseList); 
	} 

	public static void onBeforeUpdate(List<Case> caseList, Map<Id,Case> caseMap){
        System.debug('BeforeUpdate caseList : '+caseList);
        System.debug('BeforeUpdate caseMap : '+caseMap);
       
         preventSubjectUpdate(caseList, caseMap);
    } 

	public static void onBeforeInsert(List<Case> caseList){
        System.debug('BeforeInsert caseList'+caseList);
        checkfieldSubject(caseList);
	}
    //
      private static void completeSubject(List<Case> caseList){
        System.debug('completeSubject caseList : '+caseList);
        List<Case> updatelistCases = new List<Case>();
        for (Case caseRec : caseList) {
            Case newCase = new Case(); 
                String caseNumber = caseRec.CaseNumber;
                    newCase.Id = caseRec.Id;
                    newCase.Subject = '['+caseNumber+']' +'-'+ '{'+caseRec.Subject+'}';
                updatelistCases.add(newCase);
            }
        checkUpdate = false;
        update updatelistCases;
        
    } 
   
    private static void checkfieldSubject(list<case> caseList){
        System.debug('checkfieldSbubject caseList : '+ caseList);
        for(case caseRec: caseList ){
          if(String.isBlank(caseRec.Subject)){
                caseRec.addError('Please input Subject !');
          }
        }
    }
    private static void preventSubjectUpdate(List<Case> caseList,Map<Id,Case> caseMap){
        for(Case caseRec: caseList){
            Case oldCase = caseMap.get(caseRec.Id);
            System.debug('9.oldcase subject : '+oldCase.Subject);
            System.debug('10.recCase subject : '+caseRec.Subject);

            if(oldCase.Subject != caseRec.Subject && checkUpdate){
                    caseRec.addError('Please not change field Subject');
                }
            }
        }
}