import { LightningElement,wire ,api } from 'lwc';
import User_Id from '@salesforce/schema/User.Id';
import getUserInfo from '@salesforce/apex/vmo_UserController.getUserInfo';
import getPickListStatus from '@salesforce/apex/vmo_CaseController.getPickListStatus';
import getPickListCategory from '@salesforce/apex/vmo_CaseController.getPickListCategory';
import getPickListType from '@salesforce/apex/vmo_CaseController.getPickListType';
export default class Vmo_UserProfileHandler extends LightningElement {
    @api recordId;
    //userinfo
    usr_Id = '';
    usr_currentPhotoUrl ='';
    usr_fullName ='' ;
    usr_birthDate = '';
    usr_staffCode ='';
    usr_Title = '';
    usr_Email = '';
    //search
    sr_Category ='';
    sr_Subject = '';
    sr_Status = '';
    sr_TicketType = '';
    sr_StartDate;
    sr_EndDate ;
    get statusOptions() {
        return [
            { label: 'New', value: 'new' },
            { label: 'Working', value: 'working' },
            { label: 'Escalated', value: 'escalated' },
        ];
    }
    statusOptionsLoad = true;
    get categoryOptions() {
        return [
            { label: 'Category 1', value: 'category1' },
            { label: 'Category 2', value: 'category2' },
            { label: 'Category 3', value: 'category3' },
            { label: 'Category 4', value: 'category4'}
        ];
    }
    categoryOptionsLoad = true;
    get ticketTypeOptions() {
        return [
            { label: 'Home Work', value: 'homework' },
            { label: 'Clean House', value: 'clean_house' },
            { label: 'Sleeping', value: 'sleeping' },
        ]
    }
    ticketTypeOptionsLoad = true;
    handleChange(event) {
        /*this.optStatus = event.detail.value;
        this.optTicketType = event.detail.value;
        this.optCategory = event.detail.value*/
        this[event.target.dataset.id] = event.detail.value;
    }
    //fill data user
    usrData = {};
    connectedCallback() {
        this.fetchUserData();
        this.fetchData();
    }
    disconnectedCallback() {  
    }
    async fetchUserData () {
        let res = await getUserInfo();
        this.usrData = res;
        console.log('userInfo', this.usrData);
        const currentUserInfo = [
            this.usr_Id = this.usrData.Id,
            this.usr_Email = this.usrData.Email,
            this.usr_fullName = this.usrData.Name,
            this.usr_Title = this.usrData.Title,
            this.usr_birthDate = this.usrData.VMO_Birthdate__c,
            this.usr_currentPhotoUrl = this.usrData.FullPhotoUrl,
            this.usr_staffCode = this.usrData.VMO_StaffCode__c
        ]
    }
    async fetchData() {
        let data = await promise.all(getPickListType(), getPickListCategory(), getPickListStatus() )
        .then((data) => {
                const statusValue = data[0];
                const ticketTypeValue = data[1];
                const categoryValue = data[2];
                this.handleUpdateComboBoxData(statusValue, statusOptions, statusOptionsLoad )
                console.log("status :" + this.handleUpdateComboBoxData(statusValue, statusOptions, statusOptionsLoad ));
                this.handleUpdateComboBoxData(ticketTypeValue, ticketTypeOptions, ticketTypeOptionsLoad)
                console.log("ticketType :" + this.handleUpdateComboBoxData(ticketTypeValue, ticketTypeOptions, ticketTypeOptionsLoad));
                this.handleUpdateComboBoxData(categoryValue, categoryOptions, categoryOptionsLoad)
                console.log("category :" + this.handleUpdateComboBoxData(categoryValue, categoryOptions, categoryOptionsLoad));
            }
        )
        .catch(error => {
            console.log(error);
        })
    }
    handleUpdateComboBoxData(dataArr, fieldOptions, displayFieldOptions) {
        this[fieldOptions] = dataArr;
        this[displayFieldOptions] = true;
        console.log("kiểm tra comboboxdata " + dataArr);
    }
    isDisplayBtnSearch = true;
    handleClick() {
        const result = `${this.sr_Status} 
                        ${this.sr_TicketType} 
                        ${this.sr_Category} 
                        ${this.sr_Subject} 
                        ${this.sr_StartDate} 
                        ${this.sr_EndDate}`
        getSearchValue({ value: result });
    }
} 
