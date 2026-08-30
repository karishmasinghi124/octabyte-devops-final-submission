const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

app.get("/", (_req, res) => res.json({service:"octabyte-devops-demo", status:"ok"}));
app.get("/health", (_req, res) => res.status(200).json({status:"healthy"}));
app.get("/metrics", (_req, res) => res.type("text/plain").send("# HELP app_up Application availability\n# TYPE app_up gauge\napp_up 1\n"));

if (require.main === module) app.listen(port, "0.0.0.0", () => console.log(`server listening on ${port}`));
module.exports = app;
