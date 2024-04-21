

# Senior Capstone Project

This is our senior project that we made for RDE Systems. This web app is mobile responsive and has 4 different pages as well as a landing page. The idea of this web app is to visualize different influenza data.

## Table of content

- [Senior Capstone Project](#senior-capstone-project)
  - [Table of content](#table-of-content)
  - [Technologies Used](#technologies-used)
- [Website Structure](#website-structure)
  - [Home Page](#home-page)
  - [Provider Location](#provider-location)
  - [Demographics](#demographics)
  - [Doses Distribution](#doses-distribution)
  - [Hospitalization Rates](#hospitalization-rates)
  - [Data Aggregator Scripts](#data-aggregator-scripts)

## Technologies Used

- **Frontend:** HTML, CSS, JavaScript
- **Backend:** ColdFusion
- **Database:** MySQL
- **Data Visualization:** Chart.js

Our website is deployed on AWS and available [here](https://www.influenzavisualizer.serverpit.com/)

# Website Structure  

 The website consist of 5 differents pages each of them offers a variety of tools to visualize various key data points for the influenza flu seasons.

## Home Page

This is the landing page of our website.  

## Provider Location

This page provides a detailed description of each flu vaccine provider's location.  
 This page features a search tool where the user is able to search for flu vaccination providers near a specific location.  

## Demographics

This page showcases the different demographic data about flu vaccination in the U.S for different flu seasons. Included is a graph filter which includes a vast amount of feature and data that the user can tweak

## Doses Distribution

This page showcases the doses distribution in millions for each influenza seasons.  
 The user is able to toggle different seasons to be shown on the graph as well as narrow the search per week.

## Hospitalization Rates  

This page visualize the hospitalization rates for different flu seasons. The user is able to choose the year as well as the age as a filter.  
The user is able to display the data in terms of cumulative or weekly rates.  

## Data Aggregator Scripts  

This repository also includes a data aggregator for each pages. The script pulls the data from the CDC website and stores it in an SQL database. Each pages has its own individual script.  
Each pages also include an SQL script that create the database table, the user is expected to run the sql creator script for each pages before running the data aggregator script.  
