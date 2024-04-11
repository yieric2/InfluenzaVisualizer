import ProviderLocation from './ProviderLocationModel';
describe('ProviderLocation Class Tests', () => {
    const mockProviderLocation = {
        longitude: -97.7431,
        latitude: 30.2672,
        walkinsAccepted: true,
        insuranceAccepted: true,
        locAdminZip: '78701',
        locAdminCity: 'Austin',
        locAdminState: 'TX',
        locAdminStreet1: '100 Congress Ave',
        locPhone: '512-555-0198',
        webAddress: 'https://www.providerexample.com',
        mondayHours: '8:00AM-5:00PM',
        tuesdayHours: '8:00AM-5:00PM',
        wednesdayHours: '8:00AM-5:00PM',
        thursdayHours: '8:00AM-5:00PM',
        fridayHours: '8:00AM-5:00PM',
        saturdayHours: 'Closed',
        sundayHours: 'Closed',
        distance: 10 // 10km
    };

    const providerLocation = new ProviderLocation(mockProviderLocation);

    test('should correctly calculate distance', () => {
        const distance = providerLocation.calculateDistance(mockProviderLocation.latitude + 1, mockProviderLocation.longitude + 1);
        expect(distance).toBeGreaterThan(100); });

    test('should convert degrees to radians correctly', () => {
        const radians = providerLocation.degreesToRadians(180);
        expect(radians).toBe(Math.PI);
    });

    test('should format week hours in format A correctly', () => {
        const weekHoursA = providerLocation.WeekHours_A();
        expect(weekHoursA).toContain('M: 8:00AM-5:00PM T: 8:00AM-5:00PM W: 8:00AM-5:00PM Th: 8:00AM-5:00PM F: 8:00AM-5:00PM Sat: Closed Sun: Closed');
    });

    test('should format week hours in format B correctly', () => {
        const weekHoursB = providerLocation.WeekHours_B();
        expect(weekHoursB).toContain('Monday: 8:00AM-5:00PM<br>Tuesday: 8:00AM-5:00PM<br>Wednesday: 8:00AM-5:00PM<br>Thursday: 8:00AM-5:00PM<br>Friday: 8:00AM-5:00PM<br>Saturday: Closed<br>Sunday: Closed');
    });

    test('should return the full address correctly', () => {
        const fullAddress = providerLocation.getFullAddress();
        expect(fullAddress).toBe('100 Congress Ave, Austin, TX 78701');
    });

    test('should return walk-in status correctly', () => {
        expect(providerLocation.acceptsWalkIns()).toBe(true);
    });

    test('should return insurance acceptance status correctly', () => {
        expect(providerLocation.acceptsInsurance()).toBe(true);
    });
    test('should output if the location is open', () => {
        if (new Date().getHours() >= 17 || new Date().getHours() < 8 ) {
            expect(providerLocation.isOpenNow()).toBe(false);
        } else {
        expect(providerLocation.isOpenNow()).toBe(true); 
        }
    });
    test('should return the phone number correctly', () => {
        expect(providerLocation.getPhoneNumber()).toBe('512-555-0198');
    });

    test('should return the web address correctly', () => {
        expect(providerLocation.getWebsite()).toBe('https://www.providerexample.com');
    });

    test('should convert distance to miles correctly', () => {
        const miles = providerLocation.getDistanceInMiles();
        expect(miles).toBeCloseTo(6.21, 2); 
    });

});
