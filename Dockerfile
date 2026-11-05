# ------------------------------------------------------------------------------
# Future Amplifiers - static site served by nginx
#
# Build:
#   docker build -t future-amplifiers:latest .
#
# Tag for your private registry and push (see build-and-push.sh for a script):
#   docker build -t registry.example.com/web/future-amplifiers:latest .
#   docker push registry.example.com/web/future-amplifiers:latest
# ------------------------------------------------------------------------------

FROM nginx:1.27-alpine

# Labels (OCI standard)
LABEL org.opencontainers.image.title="Future Amplifiers" \
      org.opencontainers.image.description="Static website for Future Amplifiers" \
      org.opencontainers.image.source="https://github.com/s11o-4/Web_Future_Amplifiers"

# Copy the static site into the nginx document root
COPY ./ /usr/share/nginx/html/

# Copy our custom nginx configuration (replaces the image's default
# /etc/nginx/nginx.conf, which is the main config and owns the http{} block)
COPY nginx.conf /etc/nginx/nginx.conf

# Run nginx as an unprivileged, non-root user.
# The nginx.conf above sets `user nginx;` and writes the pid + temp files to
# /tmp (mounted as emptyDir in Kubernetes), so the root filesystem can be
# mounted read-only by the pod securityContext.
RUN chown -R nginx:nginx /usr/share/nginx/html \
    && mkdir -p /tmp/client_temp /tmp/proxy_temp /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp \
    && chown -R nginx:nginx /tmp

# Document and expose the serving port
EXPOSE 8080

# Run as the unprivileged "nginx" user (uid 101)
USER nginx
CMD ["nginx", "-g", "daemon off;"]
