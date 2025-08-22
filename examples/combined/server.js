const http = require('http');
const url = require('url');

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true);
  const path = parsedUrl.pathname;

  // Enable CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  res.setHeader('Content-Type', 'application/json');

  if (req.method === 'OPTIONS') {
    res.writeHead(200);
    res.end();
    return;
  }

  if (path === '/api/status') {
    res.writeHead(200);
    res.end(JSON.stringify({
      status: 'running',
      timestamp: new Date().toISOString(),
      runtime: {
        node: process.version,
        platform: process.platform,
        arch: process.arch
      }
    }, null, 2));
  } else if (path === '/api/users') {
    res.writeHead(200);
    res.end(JSON.stringify({
      users: [
        { id: 1, name: 'Alice', email: 'alice@example.com' },
        { id: 2, name: 'Bob', email: 'bob@example.com' },
        { id: 3, name: 'Charlie', email: 'charlie@example.com' }
      ]
    }, null, 2));
  } else {
    res.writeHead(404);
    res.end(JSON.stringify({ error: 'Not found' }));
  }
});

const port = 3000;
server.listen(port, () => {
  console.log(`🚀 API server running at http://localhost:${port}`);
  console.log(`📋 Available endpoints:`);
  console.log(`   GET  /api/status`);
  console.log(`   GET  /api/users`);
});
