import React, { useEffect, useState } from 'react';
import axios from 'axios';

function App() {
  const [status, setStatus] = useState('');

  useEffect(() => {
    axios.get('/api/health')
      .then(res => setStatus(res.data.status))
      .catch(err => setStatus('Error'));
  }, []);

  return (
    <div>
      <h1>DevOps Demo</h1>
      <p>Backend Status: {status}</p>
    </div>
  );
}

export default App;
