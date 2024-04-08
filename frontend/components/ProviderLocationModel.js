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
        this.locAdminZip = locAdminZip;
        this.locAdminCity = locAdminCity;
        this.locAdminState = locAdminState;
        this.locAdminStreet1 = locAdminStreet1;
        this.locPhone = locPhone;
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
    
    WeekHours() {
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
    
}
