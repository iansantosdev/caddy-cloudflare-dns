# Stage 1: Build the custom Caddy binary with the Cloudflare plugin
FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare


# Stage 2: Create the final production image
# We use the official 'caddy:latest' image as the base. This is crucial because
# it comes pre-configured with:
# 1. A non-root 'caddy' user.
# 2. A 'setcap' command applied to the caddy binary, which grants it the
#    'cap_net_bind_service' capability. This allows Caddy to bind to
#    privileged ports like 80 and 443 even while running as a non-root user.
# 3. Correct file permissions and a default working directory.
FROM caddy:latest

# Copy the custom-built Caddy binary from our builder stage, replacing the
# standard binary in the official image. The permissions and capabilities
# of the destination file (/usr/bin/caddy) are automatically handled.
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
