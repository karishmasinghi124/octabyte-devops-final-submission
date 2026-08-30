const test = require("node:test");
const assert = require("node:assert/strict");
const app = require("./server");

test("health endpoint returns healthy", async () => {
  const server = app.listen(0);
  const port = server.address().port;
  const response = await fetch(`http://127.0.0.1:${port}/health`);
  const body = await response.json();
  assert.equal(response.status, 200);
  assert.equal(body.status, "healthy");
  server.close();
});
