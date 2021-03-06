## About The Project

This is a simple Python AWS Lambda template with terraform and remote state.

It creates the following AWS resources:
    * AWS lambda       - with handler `src/lambda_handler.py`
    * AWS lambda layer - consists of packages builds from 'src/requirements.txt'
    * S3 bucket with tfstate file - for multiple developers
    * DynamoDB table  - the table contains lock/release states of terraform remote file


### Built With

* [terraform](https://www.terraform.io/docs/cli/install/apt.html)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)


## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites
#### Terraform Remote State (Once Only)
The terraform remote state is a tfstate file that locates on the S3 bucket.
It allows to work with the same AWS configuration in a team of several people
Also, we have a DynamoDB table that stores lock/release states.

    ``sh
    $ cd terraform/remote_state
    $ terraform init
    $ terraform plan
    $ terraform apply
    ```

### Installation

1. Create a lambda layer with dependencies from the requirenments.txt:
```sh
    $ cd terraform/aws/layers/
    $ pip3 install -r ../../../src/requirements.txt --target ./python
    $ zip -r9 lambda-layer.zip python/
```

2. Deploy lambda:
```sh
    $ cd terraform/aws/
    $ terraform init
    $ terraform plan
    $ terraform apply
```

## Usage

Use the repository as the example of the Python AWS Lambda creation with terraform


## License

Distributed under the MIT License. See `LICENSE` for more information.
