import getToTalClosed from '@salesforce/apex/VMO_CaseController.getToTalClosed';
import getToTalOpen from '@salesforce/apex/VMO_CaseController.getToTalOpen';
import getToTalProcessing from '@salesforce/apex/VMO_CaseController.getToTalProcessing';
import getToTalThisMonth from '@salesforce/apex/VMO_CaseController.getToTalThisMonth';
import getToTalTickets from '@salesforce/apex/VMO_CaseController.getToTalTickets';
import { LightningElement } from 'lwc';

export default class Vmo_TicketRealTimeTrackingHandler extends LightningElement {
    totalTickets_All = 0;
    totalTickets_ThisMonth = 0;
    totalTickets_SttOpen = 0;
    totalTickets_SttProcessing = 0;
    totalTickets_SttClosed = 0;

    connectedCallback() {
        this.fetchCaseData();
    }
    renderedCallback() {

    }
    disconnectedCallback() {

    }
    //fill data case
    async fetchCaseData() { 
        const data  = await Promise.all(getToTalTickets(), getToTalThisMonth(), getToTalOpen(), getToTalProcessing(), getToTalClosed())
            .then((data) => {
                this.totalTickets_All = getToTalTickets();
                this.totalTickets_ThisMonth = getToTalThisMonth();
                this.totalTickets_SttOpen = getToTalOpen();
                this.totalTickets_SttProcessing = getToTalProcessing();
                this.totalTickets_SttClosed = getToTalProcessing();
            }
            )
            .catch(this.errorCallback)
            
    }
}