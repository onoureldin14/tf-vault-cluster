# tf-vault-cluster

This repository contains Terraform configurations for setting up a Vault cluster.

# Pre-Requsite

## Google Cloud Container Registry Creation

Cloud Run will only run containers hosted on gcr.io (GCR) and its subdomains. This means that the Vault container will need to be pushed to GCR in the Google Cloud Project. Terraform cannot currently create the container registry and it is automatically created using docker push. Read the documentation for more details on pushing containers to GCR.

A quick way to get Vault into GCR for a GCP project:

Step 1:  Search https://hub.docker.com/r/hashicorp/vault/tags : For the latest version tags

Step 2: $ gcloud auth configure-docker europe-west2-docker.pkg.dev

Step 3:  $ gcloud artifacts repositories create vault-repo \
    --location=europe-west2 \
    --repository-format=DOCKER \
    --description="Vault Docker repository"


Step 4: $ docker pull --platform linux/amd64 hashicorp/vault:1.18

Step 5: $ docker tag hashicorp/vault:1.18 europe-west2-docker.pkg.dev/{{MY_GOOGLE_PROJECT_ID}}/vault-repo/vault:1.18

Step 6: $ docker push europe-west2-docker.pkg.dev/{{MY_GOOGLE_PROJECT_ID}}/vault-repo/vault:1.18

# Post Terraform Deployment

After creating the resources, the Vault instance may be initialized.

Set the VAULT_ADDR environment variable. See Vault URL from Terraform output

$ export VAULT_ADDR=https://MY-VAULT-URL.run.app


Ensure the vault is operational (might take a minute or two), uninitialized and sealed.

```sh
$ vault status
Key                      Value
---                      -----
Recovery Seal Type       gcpckms
Initialized              false
Sealed                   true
Total Recovery Shares    0
Threshold                0
Unseal Progress          0/0
Unseal Nonce             n/a
Version                  n/a
HA Enabled               false
```

## Initialize the vault.

```sh
$ vault operator init

Recovery Key 1: ...
Recovery Key 2: ...
Recovery Key 3: ...
Recovery Key 4: ...
Recovery Key 5: ...

Initial Root Token: s....

Success! Vault is initialized
```

Recovery key initialized with 5 key shares and a key threshold of 3. Please
securely distribute the key shares printed above.


## Prerequisites

- Terraform v0.12+
- AWS CLI configured
- An AWS account

## Usage

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/tf-vault-cluster.git
    cd tf-vault-cluster
    ```

2. Initialize Terraform:
    ```sh
    terraform init
    ```

3. Review and edit the `variables.tf` file to customize the configuration.

4. Apply the Terraform configuration:
    ```sh
    terraform apply
    ```

5. Confirm the apply action with `yes`.

## Variables

| Name              | Description                   | Type   | Default |
|-------------------|-------------------------------|--------|---------|
| `region`          | AWS region                    | string | `us-west-2` |
| `cluster_name`    | Name of the Vault cluster     | string | `vault-cluster` |
| `instance_type`   | EC2 instance type             | string | `t2.medium` |
| `key_name`        | Name of the SSH key pair      | string | `my-key` |

## Outputs

| Name              | Description                   |
|-------------------|-------------------------------|
| `vault_address`   | The address of the Vault cluster |

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## Authors

- Omar Din

## Acknowledgments

- Inspiration
- References
