# Caddy with Cloudflare DNS

This repository contains a Go program and a GitHub Actions workflow to automatically build a custom Caddy binary that includes the Cloudflare DNS module. The resulting binary is then published to the GitHub Package Registry.

## Overview

[Caddy](https://caddyserver.com/) is a powerful, enterprise-ready, open-source web server with automatic HTTPS. Its functionality can be extended with various plugins. This project specifically focuses on integrating the [Cloudflare DNS provider module](https://github.com/caddy-dns/cloudflare), which allows Caddy to solve DNS challenges for issuing TLS certificates for your domains managed by Cloudflare.

The primary goal of this project is to automate the build and release process. A GitHub Actions workflow runs daily to build a new Caddy Docker image with the latest available Caddy and Cloudflare DNS plugin, which is then published to the GitHub Container Registry.

## Features

-   **Automated Builds**: Automatically builds Caddy with the Cloudflare DNS plugin.
-   **Daily Updates**: Ensures the Caddy build is always up-to-date with the latest Caddy and Cloudflare DNS plugin versions.
-   **Publishing**: Pushes the custom Caddy build to the GitHub Package Registry.
-   **Easy to Use**: Can be run manually or used as a template for your own custom Caddy builds.

## Manual Build

While the primary purpose is automation, you can also build the Caddy binary manually.

### Prerequisites

-   [Go](https://golang.org/doc/install) (version 1.18 or later)
-   [xcaddy](https://github.com/caddyserver/xcaddy)

You can install `xcaddy` with the following command:
```bash
go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
```

### Building

1.  Clone the repository:
    ```bash
    git clone https://github.com/iansantosdev/caddy-cloudflare-dns.git
    cd caddy-cloudflare-dns
    ```
2.  Run the build script:
    ```bash
    go run main.go
    ```
This will compile a `caddy` binary in the current directory, which includes the Cloudflare DNS module.

## Automation with GitHub Actions

The repository includes a GitHub Actions workflow defined in `.github/workflows/release.yml`. This workflow automates the entire process.

### How it Works

1.  **Scheduled Trigger**: The workflow is scheduled to run daily.
2.  **Push Trigger**: The workflow also runs on every push to the `main` branch.
3.  **Build and Push**: The workflow proceeds to:
    a. Build a new multi-platform Caddy Docker image using `xcaddy` and the official Caddy builder image. This ensures the latest Caddy and Cloudflare DNS plugin are used.
    b. Log in to the GitHub Container Registry.
    c. Push the new build as a Docker image to the registry, tagged with the current date (e.g., `2025.08.26`), version (e.g., `2.10.2`) and `latest`.

### Setting it Up in Your Fork

To use this automation in your own fork, you will need to:

1.  **Fork this repository.**
2.  **Enable GitHub Actions** in your forked repository's settings.
3.  **Configure Secrets**: If you plan to push to a private registry or require special authentication, you might need to add secrets to your repository (e.g., `DOCKER_USERNAME`, `DOCKER_PASSWORD`). For the GitHub Package Registry, the default `GITHUB_TOKEN` is usually sufficient.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
