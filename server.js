const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
const PORT = 3000;
const NEWS_API_KEY = 'f9bdc8057813417cab0b5021b8ba033c';

app.use(cors());

app.get('/news', async (req, res) => {
  try {
    const response = await axios.get(
      `https://newsapi.org/v2/everything?domains=wsj.com&apiKey=${NEWS_API_KEY}`
    );
    res.json(response.data);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch news' });
  }
});

app.get('/slider-news', async (req, res) => {
  try {
    const response = await axios.get(
      `https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=${NEWS_API_KEY}`
    );
    res.json(response.data);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch slider news' });
  }
});

app.get('/category-news', async (req, res) => {
  const { category } = req.query;
  try {
    const response = await axios.get(
      `https://newsapi.org/v2/top-headlines?country=us&category=${category}&apiKey=${NEWS_API_KEY}`
    );
    res.json(response.data);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch category news' });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});