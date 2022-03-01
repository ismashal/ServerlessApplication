# S3 Tiggers AWS Lambda: CSV to DynamoDB Uploader using Terraform

![Alt text](image.png?raw=true "Title")

lambda function in AWS which gets triggered on a CSV upload to S3 bucket and insert the records from CSV into DynamoDB using Terraform.

<br />

## Preparation

To follow this tutorial you will need:
-   An AWS account
-   AWS CLI installed and configured
-   Terraform 12.30 CLI installed

First of all, download the source code
```
$ git clone 

$ cd 
```
For sake of simplicity you can use credentials with administrative access to your AWS account. Once you have the credentials, you will need to create the environment variables as shown below:
```
$ export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
$ export AWS_SECRET_ACCESS_KEY="YOUR_SECRETY_ACCESS_KEY"
$ export AWS_DEFAULT_REGION="us-east-1"
```

<br />


Terraform will use the above environment variables to authenticate with AWS for deploying resources. We are using the **us-east-1** region If you want to work with a different region, make the below changes in the downloaded source code.

```
# In terraform.tfvars file add the region of your choice
region = "<YOUR_REGION>"

# In .py files inside the 'zip_files' folder, update the region variable
region = '<YOUR_REGION>'
```
We will be using remote backend for our configuration. If you open the ```config.tf``` file, you will find the below configuration block:
```
provider "aws" {
  region  = var.region
  version = ">= 3.0"
}

terraform {
  backend "s3" {
    bucket = "serverlessapplicationstatefile"
    key    = "terraform.tfstate" 
    region = "us-east-1"
  }

  required_version = ">= 0.12"
}
```
Make sure you have a bucket named **serverlessapplicationstatefile** in **us-east-1** region.

<br />

## Execution

Once the setup is complete run the below commands in the downloaded folder:
```
$ terraform init

$ terraform apply -auto-approve
```
After the commands run successfully, the output console will give you an S3 bucket and Lambda function details.


If you go to your AWS account you will find lambda function deployed, **csv-2-dynamodb-lambda-func** Terraform also deploys a bucket named **csv-2-dynamodb-bucket-demo** where we will upload our .csv files for testing and a DynamoDB table named **Customers** which has **Id** as it's key attribute.

<br />

> ** Note** : The configuration creates an administrator role and attaches it to the above lambda functions. This makes sure that lambda can read files from S3 and add entries to DynamoDB.

<br />

## Testing

Run the following command to upload the sample csv file to s3:
```
$ aws s3 cp sample_csv/sample_data.csv s3://csv-2-dynamodb-bucket/sample_data.csv
```
Run the following command to read the entries from DynamoDB
```
$ aws dynamodb scan --table-name Customers
```
You should find the below 4 entries
```
1 Sham  Parker 9999999999
2 Ram   Jay    9999999999
3 Shiva Ajay   9999999999
4 Nick  Fury   9999999999
```
<br />
