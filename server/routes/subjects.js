const express = require('express');
const router = express.Router();
const db = require('../db/connection');

// Get all subjects
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM subjects');
    res.json(rows);
  } catch (err) {
    console.error('Error fetching subjects:', err);
    res.status(500).json({ error: 'Failed to fetch subjects' });
  }
});

// Get subject by ID
router.get('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM subjects WHERE id = ?', [id]);
    if (rows.length === 0) return res.status(404).json({ error: 'Subject not found' });
    res.json(rows[0]);
  } catch (err) {
    console.error('Error fetching subject:', err);
    res.status(500).json({ error: 'Failed to fetch subject' });
  }
});

// Add new subject
router.post('/', async (req, res) => {
  const { name, teacher_id } = req.body;
  try {
    const [result] = await db.query(
      'INSERT INTO subjects (name, teacher_id) VALUES (?, ?)',
      [name, teacher_id]
    );
    res.status(201).json({ id: result.insertId, name, teacher_id });
  } catch (err) {
    console.error('Error adding subject:', err);
    res.status(500).json({ error: 'Failed to add subject' });
  }
});

// Update subject
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { name, teacher_id } = req.body;
  try {
    const [result] = await db.query(
      'UPDATE subjects SET name = ?, teacher_id = ? WHERE id = ?',
      [name, teacher_id, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Subject not found' });
    res.json({ message: 'Subject updated successfully' });
  } catch (err) {
    console.error('Error updating subject:', err);
    res.status(500).json({ error: 'Failed to update subject' });
  }
});

// Delete subject
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query('DELETE FROM subjects WHERE id = ?', [id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Subject not found' });
    res.json({ message: 'Subject deleted successfully' });
  } catch (err) {
    console.error('Error deleting subject:', err);
    res.status(500).json({ error: 'Failed to delete subject' });
  }
});

module.exports = router;
