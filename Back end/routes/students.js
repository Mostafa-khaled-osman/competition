const express = require('express');
const router = express.Router();
const db = require('../db/connection');

// ✅ Get all students
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM students');
    res.json(rows);
  } catch (err) {
    console.error('Error fetching students:', err);
    res.status(500).json({ error: 'Failed to fetch students' });
  }
});

// ✅ Get student by ID
router.get('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM students WHERE id = ?', [id]);
    if (rows.length === 0) return res.status(404).json({ error: 'Student not found' });
    res.json(rows[0]);
  } catch (err) {
    console.error('Error fetching student:', err);
    res.status(500).json({ error: 'Failed to fetch student' });
  }
});

// ✅ Add new student
router.post('/', async (req, res) => {
  const { name, email, class_id } = req.body;
  try {
    const [result] = await db.query(
      'INSERT INTO students (name, email, class_id) VALUES (?, ?, ?)',
      [name, email, class_id]
    );
    res.status(201).json({ id: result.insertId, name, email, class_id });
  } catch (err) {
    console.error('Error adding student:', err);
    res.status(500).json({ error: 'Failed to add student' });
  }
});

// ✅ Update student
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { name, email, class_id } = req.body;
  try {
    const [result] = await db.query(
      'UPDATE students SET name = ?, email = ?, class_id = ? WHERE id = ?',
      [name, email, class_id, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Student not found' });
    res.json({ message: 'Student updated successfully' });
  } catch (err) {
    console.error('Error updating student:', err);
    res.status(500).json({ error: 'Failed to update student' });
  }
});

// ✅ Delete student
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query('DELETE FROM students WHERE id = ?', [id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'Student not found' });
    res.json({ message: 'Student deleted successfully' });
  } catch (err) {
    console.error('Error deleting student:', err);
    res.status(500).json({ error: 'Failed to delete student' });
  }
});

module.exports = router;
