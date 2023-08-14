import { LightningElement, wire } from 'lwc';
import {handleToTalTickets} from '@salesforce/apex/vmo_CaseController'
export default class Vmo_handleToTalTickets extends LightningElement {
    
    //tổng số Case
    handleToTalTickets( ) {

    }
    //tổng số case trong tháng
    handleTotalThisMonth() {

    }
    //tổng số case thỏa mãn đk Case.Status = "New"
    handleTotalOpen() {

    }
    //tổng số case thỏa mãn đk Case.Status != "New" && Case.isClosed= false
    handleTotalProcessing() {

    }
    //tổng số case thỏa mãn đk Case.isClosed= true
    handleTotalClosed() {

    }
    connectedCallback() {

    }
    disconnectedCallback() {

    }
}