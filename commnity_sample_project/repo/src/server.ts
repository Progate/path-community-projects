//#if SITUATION == HTTP_SERVER
import http from "node:http";
//#if ANSWER 
import fs from "node:fs/promises";
import path from "node:path";
//#endif
const server = http.createServer();

server.on("request", async (req, res) => {
  console.log("request url: ", req.url);
  //#if ANSWER 
  try {
    if (req.url === undefined) throw new Error("req.url is undefined");
    const filePath = req.url === "/" ? "/index.html" : req.url;
    const file = await fs.readFile(
      path.join(path.resolve(), "public", filePath)
    );

    const mimeTypes: { [key: string]: string } = {
      ".html": "text/html",
      ".json": "text/json",
      ".jpg": "image/jpeg",
      ".ico": "image/x-icon",
    };
    const extname = String(path.extname(req.url)).toLowerCase();
    const contentType: string =
      mimeTypes[extname] || "application/octet-stream";

    res.writeHead(200, { "content-type": contentType });
    res.end(file, "utf-8");
    return;
  } catch (err) {
    console.error("error: ", err);
    const error = err as NodeJS.ErrnoException;
    if (error.code === "ENOENT") {
      res.writeHead(404, { "content-type": "text/plain" });
      return res.end("404 Not Found");
    } else {
      res.writeHead(500, { "content-type": "text/plain" });
      return res.end("500 Internal Server Error");
    }
  }
  //#else
  // Content-Type is important for browsers.
  // https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
  res.writeHead(200, { "content-type": "text/plain" });
  res.write("hello!\n");
  res.end();
  //#endif
});

server.on("listening", () => {
  console.log("start listening!");
});

//#if ANSWER
const port = process.env.PORT ?? 12345;
server.listen(port, () => {
  console.log(`listening on http://localhost:${port}/`);
});
//#else
// Start listening 12345 port of localhost (127.0.0.1).
server.listen(12345, () => {
  console.log("listening on http://localhost:12345/");
});
//#endif
console.log("run server.js");
//#endif
