from http.server import BaseHTTPRequestHandler, HTTPServer
import requests

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        # Metadata server URL
        metadata_url = 'http://metadata.google.internal/computeMetadata/v1/'
        
        # Example: Fetch the project ID. You can customize the path to fetch different metadata.
        path = 'project/project-id'
        headers = {'Metadata-Flavor': 'Google'}
        
        try:
            # Fetch metadata
            response = requests.get(metadata_url + path, headers=headers)
            response.raise_for_status()  # Raise an exception for HTTP errors
            metadata = response.text
        except requests.RequestException as e:
            metadata = f"Error fetching metadata: {e}"
        
        # Send response
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()
        self.wfile.write(metadata.encode())

if __name__ == "__main__":
    server_address = ('', 8080)  # Serve on all addresses, port 8080
    httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)
    print("Serving HTTP on port 8080...")
    httpd.serve_forever()
