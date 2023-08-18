import { LightningElement,wire ,api } from 'lwc';
import User_Id from '@salesforce/schema/User.Id';
import getUserInfo from '@salesforce/apex/vmo_UserController.getUserInfo';
import getCategoryResult from '@salesforce/apex/vmo_CaseController.getCategoryResult';
import getStatusResult from '@salesforce/apex/vmo_CaseController.getStatusResult';
import getTicketTypeResult from '@salesforce/apex/vmo_CaseController.getTicketTypeResult';
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
    get optStatus() {
        return [
            { label: 'New', value: 'new' },
            { label: 'Working', value: 'working' },
            { label: 'Escalated', value: 'escalated' },
        ];
    }
    get optCategory() {
        return [
            { label: 'Category 1', value: 'category1' },
            { label: 'Category 2', value: 'category2' },
            { label: 'Category 3', value: 'category3' },
            { label: 'Category 4', value: 'category4'}
        ];
    }
    get optTicketType() {
        return [
            { label: 'Home Work', value: 'homework' },
            { label: 'Clean House', value: 'clean_house' },
            { label: 'Sleeping', value: 'sleeping' },
        ]
    }
    handleChange(event) {
        this.optStatus = event.detail.value;
        this.optTicketType = event.detail.value;
        this.optCategory = event.detail.value;
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
         await promise.all(getCategoryResult(), getStatusResult(), getTicketTypeResult() )
        .then((data) => {
            this.sr_Category = getCategoryResult();
            this.sr_Status = getStatusResult();
            this.sr_TicketType = getTicketTypeResult();
            }
        )
        .catch(error => {
            console.log(error);
        })
    }
    isDisplayBtnSearch = true;
    handleClick() {
    }
} 
