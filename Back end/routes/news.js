const express = require('express');
const router = express.Router();
const db = require('../db/connection');

// Get all news
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM news');
    res.json(rows);
  } catch (err) {
    console.error('Error fetching news:', err);
    res.status(500).json({ error: 'Failed to fetch news' });
  }
});

// Get news by ID
router.get('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query('SELECT * FROM news WHERE id = ?', [id]);
    if (rows.length === 0) return res.status(404).json({ error: 'News not found' });
    res.json(rows[0]);
  } catch (err) {
    console.error('Error fetching news:', err);
    res.status(500).json({ error: 'Failed to fetch news' });
  }
});

// Add news
router.post('/', async (req, res) => {
  const { title, content, date } = req.body;
  try {
    const [result] = await db.query(
      'INSERT INTO news (title, content, date) VALUES (?, ?, ?)',
      [title, content, date]
    );
    res.status(201).json({ id: result.insertId, title, content, date });
  } catch (err) {
    console.error('Error adding news:', err);
    res.status(500).json({ error: 'Failed to add news' });
  }
});

// Update news
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { title, content, date } = req.body;
  try {
    const [result] = await db.query(
      'UPDATE news SET title = ?, content = ?, date = ? WHERE id = ?',
      [title, content, date, id]
    );
    if (result.affectedRows === 0) return res.status(404).json({ error: 'News not found' });
    res.json({ message: 'News updated successfully' });
  } catch (err) {
    console.error('Error updating news:', err);
    res.status(500).json({ error: 'Failed to update news' });
  }
});

// Delete news
router.delete('/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query('DELETE FROM news WHERE id = ?', [id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'News not found' });
    res.json({ message: 'News deleted successfully' });
  } catch (err) {
    console.error('Error deleting news:', err);
    res.status(500).json({ error: 'Failed to delete news' });
  }
});

module.exports = router;
