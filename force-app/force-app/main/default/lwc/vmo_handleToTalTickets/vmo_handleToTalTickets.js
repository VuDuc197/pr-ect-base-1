import getToTalClosed from '@salesforce/apex/vmo_CaseController.getToTalClosed';
import getToTalOpen from '@salesforce/apex/vmo_CaseController.getToTalOpen';
import getToTalProcessing from '@salesforce/apex/vmo_CaseController.getToTalProcessing';
import getToTalThisMonth from '@salesforce/apex/vmo_CaseController.getToTalThisMonth';
import getToTalTickets from '@salesforce/apex/vmo_CaseController.getToTalTickets';
import { LightningElement, wire } from 'lwc';

export default class Vmo_handleToTalTickets extends LightningElement {
    totalTickets = 0;
    totalThisMonth = 0;
    totalOpen = 0;
    totalProcessing = 0;
    totalClosed = 0;

    connectedCallback() {
        this.fetchCaseData();
    }
    renderedCallback() {

    }
    disconnectedCallback() {

    }
    //fill data case
    async fetchCaseData() { 
        let res = await getToTalTickets();
        this.totalTickets = res;
        let res1 = await getToTalThisMonth();
        this.totalThisMonth = res1;
        let res2 = await getToTalOpen();
        this.totalOpen = res2;
        let res3 = await getToTalProcessing();
        this.totalProcessing = res3;
        let res4 = await getToTalClosed();
        this.totalClosed = res4;
    }
}