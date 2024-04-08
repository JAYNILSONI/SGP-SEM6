const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'your_mysql_username',
  password: 'your_mysql_password',
  database: 'sms_notification_db',
});

db.connect((err) => {
  if (err) {
    throw err;
  }
  console.log('Connected to MySQL database');
});

// Register user
app.post('/register', (req, res) => {
  const { firstName, lastName, username, email, phone, password } = req.body;
  const sql = 'INSERT INTO users (first_name, last_name, username, email, phone, password) VALUES (?, ?, ?, ?, ?, ?)';
  db.query(sql, [firstName, lastName, username, email, phone, password], (err, result) => {
    if (err) {
      console.error('Error registering user:', err);
      res.status(500).json({ error: 'Error registering user' });
    } else {
      console.log('User registered successfully');
      res.status(200).json({ message: 'User registered successfully' });
    }
  });
});

// Login user
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  const sql = 'SELECT * FROM users WHERE username = ? AND password = ?';
  db.query(sql, [username, password], (err, result) => {
    if (err) {
      console.error('Error logging in:', err);
      res.status(500).json({ error: 'Error logging in' });
    } else {
      if (result.length > 0) {
        console.log('User logged in successfully');
        res.status(200).json({ message: 'User logged in successfully' });
      } else {
        console.log('Invalid username or password');
        res.status(401).json({ error: 'Invalid username or password' });
      }
    }
  });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
