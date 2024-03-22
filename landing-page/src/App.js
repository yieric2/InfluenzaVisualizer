import React from 'react';
import './App.css';
import EmailIcon from './EmailIcon';
import PhoneIcon from './PhoneIcon';
import AddressIcon from './AddressIcon';
import healthcareImg from './Images/healthcareImg.png';

const App = () => {
  return (
    <div className="App">
      <div className="content">
        <div className="textual-content">
          <h1>Visualize flu data<br />from the CDC</h1>
          <p>Influenza Visualizer provides progressive and accessible<br /> flu data visualizations on mobile and online<br /> for everyone</p>
          <div className="contact-info">
            <h2>Contact us</h2>
            <div className="contact-item">
              <EmailIcon />
              <p>contact@company.com</p>
            </div>
            <div className="contact-item">
              <PhoneIcon />
              <p>(414) - 687 - 5892</p>
            </div>
            <div className="contact-item">
              <AddressIcon />
              <p>323 Dr Martin Luther King Jr Blvd<br />Newark, NJ 07102</p>
            </div>
          </div>
        </div>
      </div>
      <div className="image-container">
        <img src={healthcareImg} alt="Healthcare" className="healthcare-image"/>
      </div>
    </div>
  );
}

export default App;
