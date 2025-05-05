const express = require('express');
const app = express();

app.get('/api/health', (req, res) => {
  res.json({ status: 'healthy', time: new Date() });
});

app.listen({{ backend_port }}, () => console.log('Backend running on port {{ backend_port }}'));
