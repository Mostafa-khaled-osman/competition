const express = require('express');
const router = express.Router();
const db = require('../db/connection');

// ✅ Get all teachers
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM teachers');
    res.json(rows);
  } catch (err) {
    console.error('Error fetching teachers:', err);
    res.status(500).json({ error: 'Failed to fetch teachers' });
  }
});

// ✅ Get teacher by ID
router.get('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM teachers WHERE id = ?', [id]);
    if (rows.length === 0) return res.status(404).json({ error: 'Teacher not found' });
    res.json(rows[0]);
  } catch (err) {
    console.error('Error fetching teacher:', err);
    res.status(500).json({ error: 'Failed to fetch teacher' });
  }
});

// ✅ Add new teacher
router.post('/', async (req, res) => {
  const { name, email, subject } = req.body;
  try {
    const [result] = await db.query(
      'INSERT INTO teachers (name, email, subject) VALUES (?, ?, ?)',
      [name, email, subject]
    );
    res.status(201).json({ id: result.insertId, name, email, subject });
  } catch (err) {
    console.error('Error adding teacher:', err);
    res.status(500).json({ error: 'Failed to add teacher' });
  }
});

// ✅ Update teacher
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { name, email, subject } = req.body;
  try {
    const [result] = await db.query(
      'UPDATE teachers SET name = ?, email = ?, subject = ? WHERE id = ?',
      [name, email, subject, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Teacher not found' });
    res.json({ message: 'Teacher updated successfully' });
  } catch (err) {
    console.error('Error updating teacher:', err);
    res.status(500).json({ error: 'Failed to update teacher' });
  }
});

// ✅ Delete teacher
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query('DELETE FROM teachers WHERE id = ?', [id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Teacher not found' });
    res.json({ message: 'Teacher deleted successfully' });
  } catch (err) {
    console.error('Error deleting teacher:', err);
    res.status(500).json({ error: 'Failed to delete teacher' });
  }
});

module.exports = router;
