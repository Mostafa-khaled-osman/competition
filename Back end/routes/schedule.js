const express = require('express');
const router = express.Router();
const db = require('../db/connection');

// Get all schedules
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM schedule');
    res.json(rows);
  } catch (err) {
    console.error('Error fetching schedule:', err);
    res.status(500).json({ error: 'Failed to fetch schedule' });
  }
});

// Get schedule by ID
router.get('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM schedule WHERE id = ?', [id]);
    if (rows.length === 0) return res.status(404).json({ error: 'Schedule not found' });
    res.json(rows[0]);
  } catch (err) {
    console.error('Error fetching schedule:', err);
    res.status(500).json({ error: 'Failed to fetch schedule' });
  }
});

// Add schedule
router.post('/', async (req, res) => {
  const { class_id, subject_id, day, time } = req.body;
  try {
    const [result] = await db.query(
      'INSERT INTO schedule (class_id, subject_id, day, time) VALUES (?, ?, ?, ?)',
      [class_id, subject_id, day, time]
    );
    res.status(201).json({ id: result.insertId, class_id, subject_id, day, time });
  } catch (err) {
    console.error('Error adding schedule:', err);
    res.status(500).json({ error: 'Failed to add schedule' });
  }
});

// Update schedule
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { class_id, subject_id, day, time } = req.body;
  try {
    const [result] = await db.query(
      'UPDATE schedule SET class_id = ?, subject_id = ?, day = ?, time = ? WHERE id = ?',
      [class_id, subject_id, day, time, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Schedule not found' });
    res.json({ message: 'Schedule updated successfully' });
  } catch (err) {
    console.error('Error updating schedule:', err);
    res.status(500).json({ error: 'Failed to update schedule' });
  }
});

// Delete schedule
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query('DELETE FROM schedule WHERE id = ?', [id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Schedule not found' });
    res.json({ message: 'Schedule deleted successfully' });
  } catch (err) {
    console.error('Error deleting schedule:', err);
    res.status(500).json({ error: 'Failed to delete schedule' });
  }
});

module.exports = router;
