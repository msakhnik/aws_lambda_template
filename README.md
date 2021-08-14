## About The Project

This is a Python AWS Lambda + Terraform + Remote State + Lambda Layer template


It creates the following AWS resources:

 * *AWS lambda*       - with handler `src/lambda_handler.py`
    
 * *AWS lambda layer* - consists of packages build from 'src/requirements.txt'
    
 * *S3 bucket with tfstate file* - for multiple developers
    
 * *DynamoDB table*  - the table contains lock/release states of terraform remote file
   


### Built With

* [Terraform](https://www.terraform.io/docs/cli/install/apt.html)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)


## Getting Started

To get a copy up and running follow these simple steps.

### Prerequisites
#### Terraform Remote State (Once Only)
The terraform remote state is a tfstate file that locates on the S3 bucket.
It allows working with the same AWS configuration in a team of several people
Also, we have a DynamoDB table that stores lock/release states.

```sh
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

It is distributed under the MIT License. See `LICENSE` for more information.
