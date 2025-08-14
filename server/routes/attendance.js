const express = require('express');
const router = express.Router();
const db = require('../db/connection');

// Get all attendance records
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM attendance');
    res.json(rows);
  } catch (err) {
    console.error('Error fetching attendance:', err);
    res.status(500).json({ error: 'Failed to fetch attendance' });
  }
});

// Get attendance by ID
router.get('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM attendance WHERE id = ?', [id]);
    if (rows.length === 0) return res.status(404).json({ error: 'Attendance record not found' });
    res.json(rows[0]);
  } catch (err) {
    console.error('Error fetching attendance:', err);
    res.status(500).json({ error: 'Failed to fetch attendance' });
  }
});

// Add attendance record
router.post('/', async (req, res) => {
  const { student_id, date, status } = req.body;
  try {
    const [result] = await db.query(
      'INSERT INTO attendance (student_id, date, status) VALUES (?, ?, ?)',
      [student_id, date, status]
    );
    res.status(201).json({ id: result.insertId, student_id, date, status });
  } catch (err) {
    console.error('Error adding attendance:', err);
    res.status(500).json({ error: 'Failed to add attendance' });
  }
});

// Update attendance record
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { student_id, date, status } = req.body;
  try {
    const [result] = await db.query(
      'UPDATE attendance SET student_id = ?, date = ?, status = ? WHERE id = ?',
      [student_id, date, status, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Attendance record not found' });
    res.json({ message: 'Attendance updated successfully' });
  } catch (err) {
    console.error('Error updating attendance:', err);
    res.status(500).json({ error: 'Failed to update attendance' });
  }
});

// Delete attendance record
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query('DELETE FROM attendance WHERE id = ?', [id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Attendance record not found' });
    res.json({ message: 'Attendance deleted successfully' });
  } catch (err) {
    console.error('Error deleting attendance:', err);
    res.status(500).json({ error: 'Failed to delete attendance' });
  }
});

module.exports = router;
