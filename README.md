## OMyClasses.com | github.com/the-teacher

This project is an open-source solution that was created by Ilya Zykin (github.com/the-teacher) to provide a platform for online classes and educational content.

## TEST SERVER SETUP

This is a test server setup for building a local playground environment for experiments with web development and deployment.

### **SERVER** Configuration

Contains configuration files and scripts for setting up and managing the server environment for the Rails application. This includes Docker configurations, SSH key management, and deployment scripts.

The server is a minimal Debian SSH server with the following packages installed:

- openssh-server: SSH daemon for remote access
- sudo: allows users to run commands as other users
- curl: command line tool for transferring data with URLs
- wget: utility for non-interactive download of files from web

## HOW TO USE

1. `git clone https://github.com/OMyClasses-com/test-server.git`
2. `cd test-server`
3. `make up`

### License

MIT License.
