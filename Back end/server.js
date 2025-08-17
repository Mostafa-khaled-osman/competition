const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const bodyParser = require('body-parser');

dotenv.config();
const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Routes
app.use('/api/teachers', require('./routes/teachers'));
app.use('/api/students', require('./routes/students'));
app.use('/api/classes', require('./routes/classes'));
app.use('/api/subjects', require('./routes/subjects'));
app.use('/api/assignments', require('./routes/assignments'));
app.use('/api/news', require('./routes/news'));
app.use('/api/schedule', require('./routes/schedule'));
app.use('/api/attendance', require('./routes/attendance'));

// Test route
app.get('/', (req, res) => {
  res.send('SchoolConnect API is running 🚀');
});

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`✅ Server running on port ${PORT}`);
});
