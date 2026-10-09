from http.server import BaseHTTPRequestHandler, HTTPServer
import os

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        msg = os.environ.get("GREETING", "hello, version 2")
        self.wfile.write(msg.encode())

HTTPServer(("0.0.0.0", 8000), Handler).serve_forever()
