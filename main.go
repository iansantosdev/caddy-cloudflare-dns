package main

import (
	"log"
	"os"
	"os/exec"
)

func main() {
	log.Println("Building Caddy with the Cloudflare DNS plugin...")

	// This command builds Caddy with the Cloudflare DNS module.
	// It assumes `xcaddy` is installed and in the system's PATH.
	// You can install `xcaddy` by running:
	// go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
	cmd := exec.Command("xcaddy", "build", "--with", "github.com/caddy-dns/cloudflare")

	// Pipe the command's output to the console so we can see the build progress.
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	// Execute the command.
	if err := cmd.Run(); err != nil {
		log.Fatalf("Failed to build Caddy: %v", err)
	}

	log.Println("Caddy built successfully!")
	log.Println("The binary is located in the current directory.")
}
