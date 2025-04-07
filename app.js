const http = require('http');
const PORT = 80;

const server = http.createServer((req, res) => {
  res.end('Hello from Docker container!');
});

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});









