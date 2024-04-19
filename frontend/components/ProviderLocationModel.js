export default class ProviderLocation {
    constructor({
        longitude,
        latitude,
        walkinsAccepted,
        insuranceAccepted,
        locAdminZip,
        locAdminCity,
        locAdminState,
        locAdminStreet1,
        locPhone,
        webAddress,
        mondayHours,
        tuesdayHours,
        wednesdayHours,
        thursdayHours,
        fridayHours,
        saturdayHours,
        sundayHours,
        distance
    }) {
        this.longitude = longitude;
        this.latitude = latitude;
        this.walkinsAccepted = walkinsAccepted;
        this.insuranceAccepted = insuranceAccepted;
        this.locAdminZip = this.cleanString(locAdminZip);
        this.locAdminCity = this.cleanString(locAdminCity);
        this.locAdminState = this.cleanString(locAdminState);
        this.locAdminStreet1 = this.cleanString(locAdminStreet1);
        this.locPhone = this.formatPhoneNumber(locPhone);
        this.webAddress = webAddress;
        this.mondayHours = mondayHours;
        this.tuesdayHours = tuesdayHours;
        this.wednesdayHours = wednesdayHours;
        this.thursdayHours = thursdayHours;
        this.fridayHours = fridayHours;
        this.saturdayHours = saturdayHours;
        this.sundayHours = sundayHours;
        this.distance = distance;
    }

    cleanString(input) {
        return input.replace(/[^\x20-\x7E]/g, '');
    }
    formatPhoneNumber(input) {
        let stringInput = input.toString().split('.')[0];  
        return stringInput.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
    }
    

    calculateDistance(fromLat, fromLng) {
        const earthRadiusKm = 6371;
        const dLat = this.degreesToRadians(fromLat - this.latitude);
        const dLon = this.degreesToRadians(fromLng - this.longitude);
        
        const lat1 = this.degreesToRadians(this.latitude);
        const lat2 = this.degreesToRadians(fromLat);

        const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
        return earthRadiusKm * c;
    }

    degreesToRadians(degrees) {
        return degrees * Math.PI / 180;
    }
    
    WeekHours_A() {
        return "M: " + this.mondayHours + " T: " + this.tuesdayHours +  " W: " + this.wednesdayHours + " Th: " + this.thursdayHours +  " F: " + this.fridayHours + " Sat: " + this.saturdayHours + " Sun: " + this.sundayHours;
    }

    WeekHours_B() {
        return "Monday: " + this.mondayHours + "<br>" + "Tuesday: " + this.tuesdayHours + "<br>" + "Wednesday: " + this.wednesdayHours + "<br>" + "Thursday: " + this.thursdayHours + "<br>" + "Friday: " + this.fridayHours + "<br>" + "Saturday: " + this.saturdayHours + "<br>" + "Sunday: " + this.sundayHours;
    }

    getFullAddress() {
        return `${this.locAdminStreet1}, ${this.locAdminCity}, ${this.locAdminState} ${this.locAdminZip}`;
    }
    acceptsWalkIns() {
        return this.walkinsAccepted;
    }
    
    acceptsInsurance() {
        return this.insuranceAccepted;
    }
    
    isOpenNow() {
        const now = new Date();
        const day = now.getDay(); // Sunday = 0, Monday = 1, ..., Saturday = 6
        const hour = now.getHours();
        const minute = now.getMinutes();
        
        let todayHours;
        switch(day) {
            case 0: todayHours = this.sundayHours; break;
            case 1: todayHours = this.mondayHours; break;
            case 2: todayHours = this.tuesdayHours; break;
            case 3: todayHours = this.wednesdayHours; break;
            case 4: todayHours = this.thursdayHours; break;
            case 5: todayHours = this.fridayHours; break;
            case 6: todayHours = this.saturdayHours; break;
            default: return false; // just in case
        }
    
        return this.isOpen(todayHours, hour, minute);
    }
    
    isOpen(hoursString, currentHour, currentMinute) {
        if (hoursString === "Closed") {
            return false;
        }

        const [openTime, closeTime] = hoursString.split('-');
        const [start, end] = [openTime.slice(-2) === 'AM' ? openTime.slice(0, -2) : openTime, closeTime.slice(-2) === 'AM' ? closeTime.slice(0, -2) : closeTime];
        const [openHour, openMinute] =  start.substring(0,4).split(':').map(Number);
        const [closeHourRaw, closeMinute] = end.substring(0,4).split(':').map(Number);
        
        const closeHour = closeTime.slice(-2) === 'PM' && closeHourRaw < 12 ? closeHourRaw + 12 : closeHourRaw;

        const convertedOpenHour = openTime.slice(-2) === 'PM' && openHour < 12 ? openHour + 12 : openHour;
        const convertedCloseHour = closeTime.slice(-2) === 'PM' && closeHour < 12 ? closeHour + 12 : closeHour;


        const startMinutes = convertedOpenHour * 60 + openMinute;
        const endMinutes = convertedCloseHour * 60 + closeMinute;
        const nowMinutes = currentHour * 60 + currentMinute;
        return nowMinutes >= startMinutes && nowMinutes < endMinutes;
    }
    
    getPhoneNumber() {
        return this.locPhone;
    }

    getWebsite() {
        return this.webAddress;
    }

    getDistanceInMiles() {
        return Math.round((this.distance / 1.609344) * 100) / 100;
    }

    displayInfo() {
        return `
        <div class="d-flex w-100 justify-content-between">
        <h5 class="mb-1">${this.getFullAddress()}</h5>
        <small> approx. ${this.getDistanceInMiles()} mi</small>
        </div>
        <p class="mb-1">Phone: ${this.getPhoneNumber()}</p>
        <p class="mb-1">Web: <a href="${this.getWebsite()}/">${this.getWebsite()}</a></p>
        <p class="mb-1">Hours: ${this.WeekHours_A()}</p>
        <small>Walk-ins: ${this.acceptsWalkIns() ? 'Yes' : 'No'} Insurance: ${this.acceptsInsurance() ? 'Yes' : 'No'}</small>
    `;
    }

    displayInfo_B() {
        return `
        <div class="d-flex w-100 justify-content-between">
          <div class="flex-grow-1" style="">
            <h7 class="mb-1"><b>${this.getFullAddress()}</b></h7>
          </div>
          <div>
            <small><b>approx. ${this.getDistanceInMiles()} mi</b></small>
            <p class="mb-1"><b>Phone: ${this.getPhoneNumber()}</b></p>
            <p class="mb-1"><b>Web: <a href="${this.getWebsite()}">${this.getWebsite()}</a></b></p>
            <p class="mb-1"><b>Hours: ${this.WeekHours_A()}</b></p>
            <small><b>Walk-ins: ${this.acceptsWalkIns() ? 'Yes' : 'No'} Insurance: ${this.acceptsInsurance() ? 'Yes' : 'No'}</b></small>
          </div>
        </div>
          `;
    }

    
}
