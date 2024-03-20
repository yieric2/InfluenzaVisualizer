export type Location = {
    coords: google.maps.LatLngLiteral;
    city: string;
    phone_number?: string;
    address?: string;
    state?: string;
    zip?: string;
    website?: string;
    insurance_accepted?: boolean;
    walking_accepted?: boolean;
};

