const express = require('express');
const router = express.Router();
const db = require('../db/connection');

// Get all assignments
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM assignments');
    res.json(rows);
  } catch (err) {
    console.error('Error fetching assignments:', err);
    res.status(500).json({ error: 'Failed to fetch assignments' });
  }
});

// Get assignment by ID
router.get('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM assignments WHERE id = ?', [id]);
    if (rows.length === 0) return res.status(404).json({ error: 'Assignment not found' });
    res.json(rows[0]);
  } catch (err) {
    console.error('Error fetching assignment:', err);
    res.status(500).json({ error: 'Failed to fetch assignment' });
  }
});

// Add new assignment
router.post('/', async (req, res) => {
  const { title, description, due_date, subject_id } = req.body;
  try {
    const [result] = await db.query(
      'INSERT INTO assignments (title, description, due_date, subject_id) VALUES (?, ?, ?, ?)',
      [title, description, due_date, subject_id]
    );
    res.status(201).json({ id: result.insertId, title, description, due_date, subject_id });
  } catch (err) {
    console.error('Error adding assignment:', err);
    res.status(500).json({ error: 'Failed to add assignment' });
  }
});

// Update assignment
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { title, description, due_date, subject_id } = req.body;
  try {
    const [result] = await db.query(
      'UPDATE assignments SET title = ?, description = ?, due_date = ?, subject_id = ? WHERE id = ?',
      [title, description, due_date, subject_id, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Assignment not found' });
    res.json({ message: 'Assignment updated successfully' });
  } catch (err) {
    console.error('Error updating assignment:', err);
    res.status(500).json({ error: 'Failed to update assignment' });
  }
});

// Delete assignment
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query('DELETE FROM assignments WHERE id = ?', [id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Assignment not found' });
    res.json({ message: 'Assignment deleted successfully' });
  } catch (err) {
    console.error('Error deleting assignment:', err);
    res.status(500).json({ error: 'Failed to delete assignment' });
  }
});

module.exports = router;
