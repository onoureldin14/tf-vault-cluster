# tf-vault-cluster

This repository contains Terraform configurations for setting up a Vault cluster.

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
