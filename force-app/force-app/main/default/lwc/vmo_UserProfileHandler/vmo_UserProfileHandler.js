import { LightningElement,wire ,api } from 'lwc';
import User_Id from '@salesforce/schema/User.Id';
import getUserInfor from '@salesforce/apex/vmo_UserController.getUserInfor';
import { getRecord, getFieldValue  } from 'lightning/uiRecordApi';
export default class Vmo_UserProfileHandler extends LightningElement {
    @api recordId;
    currentPhotoUrl ;
    fullName;
    birthDate;
    staffCode;

    //fill data user
    usrData = {};
    //handler button Search
    handleBtnSearch() {

    }
    connectedCallback() {
        this.fetchUserData();
    }
    disconnectedCallback() {
        
    }
    async fetchUserData () {
        let res = await getUserInfor();
        this.usrData = res;
    }
}