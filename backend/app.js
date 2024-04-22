const express = require('express');
const axios = require('axios');
const cors = require('cors');
require('dotenv').config();
const app = express(); 
const allowedOrigins = ['http://127.0.0.1:3000', 'http://127.0.0.1:8500'];
app.use(cors({
    origin: function (origin, callback) {
        if (!origin || allowedOrigins.indexOf(origin) !== -1) {
            callback(null, true);
        } else {
            callback(new Error('Not allowed by CORS'));
        }
    },
    optionsSuccessStatus: 200
}));

app.use(express.json())

app.get('/api/GmapKey', (req, res) => {
    res.send({ key: process.env.API_KEY });
});

app.get('/api/geocode', async (req, res) => {
    const { address } = req.query;
    if (!address) {
        return res.status(400).json({ error: 'Address parameter is required' });
    }
    const apiKey = process.env.API_KEY;
    const encodedAddress = encodeURIComponent(address);
    const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodedAddress}&key=${apiKey}`;

    try {
        const response = await axios.get(url);
        res.json(response.data);
    } catch (error) {
        console.error('Error calling the Google Maps Geocoding API:', error);
        res.status(500).json({ error: 'Failed to fetch geocoding data' });
    }
});


app.listen(process.env.PORT, () => {
    console.log(`Server is running on port ${process.env.PORT}`);
});
