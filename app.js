const express = require('express');
const bodyParser = require('body-parser');
const twilio = require('twilio');

const app = express();

// Middleware
app.use(bodyParser.urlencoded({ extended: false }));

// Your Twilio Account SID, Auth Token, and Twilio phone number
const accountSid = 'your_account_sid';
const authToken = 'your_auth_token';
const twilioNumber = 'your_twilio_phone_number';

// Initialize Twilio client
const client = twilio(accountSid, authToken);

// Route to receive SMS
app.post('/sms', (req, res) => {
    const senderNumber = req.body.From;
    const messageBody = req.body.Body;
    
    // Process the received SMS message (e.g., trigger desired action)
    console.log(`Received SMS from: ${senderNumber}\nMessage: ${messageBody}`);
    
    res.status(200).end();
});

// Route to send SMS
app.get('/send-sms', (req, res) => {
    const receiverNumber = req.query.to;
    const message = req.query.message || 'Hello from your desired device!';
    
    // Send SMS using Twilio
    client.messages.create({
        body: message,
        from: twilioNumber,
        to: receiverNumber
    })
    .then(() => {
        console.log('SMS sent successfully!');
        res.send('SMS sent successfully!');
    })
    .catch((err) => {
        console.error('Error sending SMS:', err);
        res.status(500).send('Error sending SMS');
    });
});

// Start the server
const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
