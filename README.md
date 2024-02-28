# Flu Vaccination Provider Locations

## Overview
This document describes the functionality of the Flu Vaccination Provider Locations feature, designed to display and locate flu vaccination providers across the country. The feature aims to provide users with an easy way to find the nearest vaccination services by searching via location names or zip codes.

## Features

### Provider Location Display
- Display a comprehensive list of flu vaccination providers nationwide.
- Utilize interactive maps to show the geographical location of each provider.

### Search Functionality
- Allow users to search for providers by entering a location name or zip code.
- Display search results on the map and in a list format, highlighting the nearest providers based on the user's search criteria.

### Google Maps Integration
- Use the Google Maps API to implement map functionalities, including:
  - Interactive map displays
  - Geolocation services to find the user's current location
  - Custom markers to denote provider locations on the map

## Technical Details

### Google Maps API
The Google Maps API is utilized to power the mapping features of this application. Key functionalities include:
- **Geocoding**: Convert location names and zip codes into geographical coordinates.
- **Map Rendering**: Display an interactive map on the application interface.
- **Markers and Info Windows**: Place markers on the map for each provider location, with info windows providing details about each provider.

### Data Source
Influenza Visualizer CDC & Google Map API

## User Guide

1. **Accessing the Map**
   - The map is accessible from the main dashboard of the application.
   - Users can pan and zoom the map to explore different regions.

2. **Searching for Providers**
   - Enter a location name or zip code in the search bar.
   - Press the search button or hit enter to view the results.

3. **Viewing Provider Details**
   - Click on any map marker to view detailed information about the provider, including name, address, and available services.

