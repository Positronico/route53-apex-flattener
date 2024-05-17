
# Route53 Apex Domain CNAME Flattening

This Python script performs CNAME flattening for an apex domain in AWS Route53 by resolving the IP addresses of a given DNS entry and updating the apex domain's A records with those IP addresses.

## Table of Contents

- [Overview](#overview)
- [Why Use This Script?](#why-use-this-script)
- [What is CNAME Flattening?](#what-is-cname-flattening)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Usage](#usage)
- [Examples](#examples)
- [Using Docker](#using-docker)

## Overview

AWS Route53 does not natively support CNAME records at the apex (root) of a domain. This script provides a workaround by resolving the IP addresses of a given CNAME target and updating the apex domain's A records with these IP addresses. This approach is often needed when using services like Cloudflare's Partial DNS (CNAME) setup.

## Why Use This Script?

One common use case is integrating your domain with Cloudflare using the Partial DNS (CNAME) setup method. Cloudflare requires a CNAME record to point to their service, but if you want to use your apex domain (e.g., `example.com`), AWS Route53 does not support CNAME records at the apex. This script resolves that issue by creating A records with the resolved IP addresses from the CNAME target.

## What is CNAME Flattening?

CNAME Flattening is the process of using a CNAME record at the apex of a domain, which is typically not allowed in standard DNS configurations. The DNS provider resolves the CNAME to its corresponding IP addresses and then returns those IP addresses as A records. This script manually performs CNAME Flattening by resolving the IP addresses of the CNAME target and updating the apex domain's A records with those IP addresses.

## Prerequisites

- Python 3.6 or higher
- AWS credentials with permissions to modify Route53 records

## Setup

1. **Clone the repository**:

    ```sh
    git clone https://github.com/your-username/route53-apex-flattener.git
    cd route53-apex-flattener
    ```

2. **Create a virtual environment**:

    ```sh
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```

3. **Install the dependencies**:

    ```sh
    pip install -r requirements.txt
    ```

4. **Set up your AWS credentials**:

    Ensure that your AWS credentials are set in environment variables:

    ```sh
    export AWS_ACCESS_KEY_ID='your_access_key_id'
    export AWS_SECRET_ACCESS_KEY='your_secret_access_key'
    export AWS_SESSION_TOKEN='your_session_token'  # If applicable
    ```

## Usage

To use the script, provide the domain and the source DNS entry as command-line arguments. You can also use the `--dry-run` flag to print the planned changes without executing them.

### Command-Line Arguments

- `--domain`: The apex domain hosted in Route53.
- `--source-dns`: The DNS entry to serve as the source of the new configuration.
- `--dry-run`: If specified, the script will only print the planned changes without executing them.

### Examples

**Dry Run**: Check the planned changes without applying them:

```sh
./route53-apex-flattener --domain example.com --source-dns target.example.net --dry-run
```

**Apply Changes**: Execute the changes:

```sh
./route53-apex-flattener --domain example.com --source-dns target.example.net
```

## Using Docker

### Building the Docker Image

To build the Docker image, run the following command in your project directory:

```sh
docker build -t route53-apex-flattener .
```

### Running the Docker Container

Use the following command to run the Docker container, providing the necessary environment variables and command-line arguments:

```sh
docker run --rm \
  -e AWS_ACCESS_KEY_ID='your_access_key_id' \
  -e AWS_SECRET_ACCESS_KEY='your_secret_access_key' \
  -e AWS_SESSION_TOKEN='your_session_token' \
  -e DOMAIN='example.com' \
  -e SOURCE_DNS='target.example.net' \
  -e SLEEP_INTERVAL=60 \
  route53-apex-flattener
```

## Additional Information

### Cloudflare Partial DNS (CNAME) Setup

Cloudflare's Partial DNS (CNAME) setup allows you to manage DNS records through Cloudflare without transferring your domain's nameservers. This is useful for leveraging Cloudflare's services while keeping your DNS management in your existing provider. More details can be found on [Cloudflare's documentation](https://support.cloudflare.com/hc/en-us/articles/200168876-How-do-I-do-CNAME-setup-).

### AWS Route53 and CNAME Flattening

As of now, AWS Route53 does not support CNAME records at the apex of a domain. This script provides a workaround by resolving the IP addresses of the CNAME target and creating A records for those IP addresses in Route53. This approach ensures that your apex domain can point to services that require a CNAME record.

## Contributing

If you have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
