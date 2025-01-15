# Nginx Image Cache Management

Caches an image after the 2nd request. Purges cache on demand

## Requests

### 1. Get Images

#### Endpoint:

```
GET /<image_name>
```

#### Example:

```bash
curl -I http://localhost:8080/image1.jpg
```

#### Response:

- **200 OK**: The image is served successfully.
- **Headers**:
  - `X-Cache-Status`: Indicates if the response was served from the cache.
    - `MISS`: The image was not found in the cache and fetched from the backend.
    - `HIT`: The image was served from the cache.

#### Sample Output:

```plaintext
HTTP/1.1 200 OK
Content-Type: image/jpeg
X-Cache-Status: MISS
```

---

### 2. Purge Image Cache

Use this request to purge the cached version of a specific image file.

#### Endpoint:

```
PURGE /purge_cache/?file=<image_name>
```

#### Example:

```bash
curl -X PURGE "http://localhost:8080/purge_cache/?file=image1.jpg"
```

#### Parameters:

- `file`: The name of the image file to purge from the cache (e.g., `image1.jpg`).

#### Response:

- **200 OK**: The cache for the specified image was purged successfully.
- **400 Bad Request**: The request was invalid (e.g., `file` parameter missing).
- **404 Not Found**: The image was not found in the cache.

#### Sample Output:

```plaintext
HTTP/1.1 200 OK
Content-Length: 12
Content-Type: text/plain

/image1.jpg
```

---

## Testing the Setup

1. **Fetch an Image**:

   ```bash
   curl -I http://localhost:8080/image1.jpg
   ```

   - Observe the `X-Cache-Status` header.

2. **Purge the Cache**:

   ```bash
   curl -X PURGE "http://localhost:8080/purge_cache/?file=image1.jpg"
   ```

   - Confirm the cache has been purged.

3. **Re-fetch the Image**:
   ```bash
   curl -I http://localhost:8080/image1.jpg
   ```
   - Observe the `X-Cache-Status` header reset to `MISS`.
