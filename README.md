# Web_Future_Amplifiers

Static website for **Future Amplifiers**. Plain HTML/CSS/JS (Bootstrap 4), no
build step required. Served by nginx inside a Docker container, ready to be
pushed to a private registry and deployed on Kubernetes.

## Project structure

```
.
├── index.html              # Landing page
├── features.html           # Features page
├── css/                    # Bootstrap CSS (local)
├── js/                     # Bootstrap JS + jQuery/Popper (local)
├── JavaScript/             # Site-specific JS
├── style/                  # Custom CSS
├── icons/ , images/        # Static assets
├── Dockerfile              # nginx-based image
├── nginx.conf              # nginx site config (security headers, /healthz)
├── .dockerignore           # Files excluded from the image
├── build-and-push.sh       # Build + push to private registry
└── k8s/                    # Kubernetes manifests
    ├── namespace.yaml
    ├── deployment.yaml
    ├── service.yaml
    └── ingress.yaml
```

## Run locally without Docker

Just open `index.html` in a browser, or serve it:

```bash
python3 -m http.server 8000
# http://localhost:8000
```

## Build the Docker image

```bash
docker build -t future-amplifiers:latest .
```

### Push to your private registry

Edit `build-and-push.sh` (or set env vars), then:

```bash
./build-and-push.sh                     # tag "latest"
./build-and-push.sh v1.2.3              # specific tag
```

Or manually:

```bash
REGISTRY=registry.example.com
docker tag future-amplifiers:latest ${REGISTRY}/web/future-amplifiers:latest
docker push ${REGISTRY}/web/future-amplifiers:latest
```

## Deploy on Kubernetes

1. Edit `k8s/deployment.yaml` and set your registry image.
2. Edit `k8s/ingress.yaml` and set your real hostname.

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml -f k8s/service.yaml -f k8s/ingress.yaml
```

### Verify

```bash
kubectl -n future-amplifiers get pods
kubectl -n future-amplifiers get svc,ingress
```

The image serves on port `8080` (non-root) and exposes `/healthz` for
liveness/readiness probes.
