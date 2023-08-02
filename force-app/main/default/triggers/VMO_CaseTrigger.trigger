/* Project Base VMO
* Created Date: 24/07/2023
* Created By: LocHN
* Descript: VMO_CaseTrigger
* PIC: Ducvv.
*/
trigger VMO_CaseTrigger on Case (before update, before insert, after insert) {
    if(Trigger.isBefore && Trigger.isUpdate) {
        VMO_CaseTriggerHandler.onBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isBefore && Trigger.isInsert) {
        VMO_CaseTriggerHandler.onBeforeInsert(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isInsert) {
      VMO_CaseTriggerHandler.onAfterInsert(Trigger.new);
    }   
}