const express = require('express');
const router = express.Router();
const db = require('../db/connection');

// ✅ Get all classes
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM classes');
    res.json(rows);
  } catch (err) {
    console.error('Error fetching classes:', err);
    res.status(500).json({ error: 'Failed to fetch classes' });
  }
});

// ✅ Get class by ID
router.get('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM classes WHERE id = ?', [id]);
    if (rows.length === 0) return res.status(404).json({ error: 'Class not found' });
    res.json(rows[0]);
  } catch (err) {
    console.error('Error fetching class:', err);
    res.status(500).json({ error: 'Failed to fetch class' });
  }
});

// ✅ Add new class
router.post('/', async (req, res) => {
  const { name, grade } = req.body;
  try {
    const [result] = await db.query(
      'INSERT INTO classes (name, grade) VALUES (?, ?)',
      [name, grade]
    );
    res.status(201).json({ id: result.insertId, name, grade });
  } catch (err) {
    console.error('Error adding class:', err);
    res.status(500).json({ error: 'Failed to add class' });
  }
});

// ✅ Update class
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { name, grade } = req.body;
  try {
    const [result] = await db.query(
      'UPDATE classes SET name = ?, grade = ? WHERE id = ?',
      [name, grade, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Class not found' });
    res.json({ message: 'Class updated successfully' });
  } catch (err) {
    console.error('Error updating class:', err);
    res.status(500).json({ error: 'Failed to update class' });
  }
});

// ✅ Delete class
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query('DELETE FROM classes WHERE id = ?', [id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Class not found' });
    res.json({ message: 'Class deleted successfully' });
  } catch (err) {
    console.error('Error deleting class:', err);
    res.status(500).json({ error: 'Failed to delete class' });
  }
});

module.exports = router;
