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
   
    public class SelectOption {
        @AuraEnabled public String label {get; set;}
        @AuraEnabled public String value {get; set;}
        public SelectOption(){
            this.value = VMO_CommonConstant.CHAIN_NULL;
            this.label = VMO_CommonConstant.CHAIN_NULL;
        }
        public SelectOption(String value, String label) {
            this.value = value;
            this.label = label;
        }
    }
    @AuraEnabled
    public static List<SelectOption> getPickListStatus() {
        List<SelectOption> optionsStatus = new List<SelectOption>();
                Schema.DescribeFieldResult fieldResult = Case.Status.getDescribe();
                    List<Schema.PicklistEntry> fieldList = fieldResult.getPicklistValues();
                    optionsStatus.add(new SelectOption('','--None--'));
                            for( Schema.PicklistEntry fieldItem : fieldList) {
                                optionsStatus.add(new SelectOption(fieldItem.getLabel(), fieldItem.getValue()));
                                    }             
            return optionsStatus;
        }
    @AuraEnabled
    public static List<SelectOption> getPickListCategory() {
        List<SelectOption> optionsCategory = new List<SelectOption>();
                Schema.DescribeFieldResult fieldResult = Case.VMO_Category__c.getDescribe();
                    List<Schema.PicklistEntry> fieldList = fieldResult.getPicklistValues();
                    optionsCategory.add(new SelectOption('','--None--'));
                            for( Schema.PicklistEntry fieldItem : fieldList) {
                                optionsCategory.add(new SelectOption(fieldItem.getLabel(), fieldItem.getValue()));
                                    }   
            return optionsCategory;
        }
    @AuraEnabled
    public static List<SelectOption> getPickListType() {
        List<SelectOption> optionsType = new List<SelectOption>();
                Schema.DescribeFieldResult fieldResult = Case.Type.getDescribe();
                    List<Schema.PicklistEntry> fieldList = fieldResult.getPicklistValues();
                    optionsType.add(new SelectOption('','--None--'));
                            for( Schema.PicklistEntry fieldItem : fieldList) {
                                optionsType.add(new SelectOption(fieldItem.getLabel(), fieldItem.getValue()));
                                    }   
            return optionsType;
        }   
    @AuraEnabled(cacheable=true)
    public static void getSearchValue (String value) {
        System.debug(value);
    }
}