aws ec2 create-key-pair \
--key-name eksKeyPair \
--query 'KeyMaterial' \
--output text > eksKeyPair.pem

aws ec2 describe-key-pairs \
--key-name eksKeyPair

chmod 400 ./eksKeyPair.pem
ssh-keygen -y -f ./eksKeyPair.pem > my-public-key.pub


- name: "Configure AWS Credentials" Action For GitHub Actions
  uses: aws-actions/configure-aws-credentials@v1


jobs:
  deploy:
    name: Upload to Amazon S3
    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v2

    - name: Configure AWS credentials from Test account
      uses: aws-actions/configure-aws-credentials@v1
      with:
        aws-access-key-id: ${{ secrets.TEST_AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.TEST_AWS_SECRET_ACCESS_KEY }}
        aws-region: us-east-1

    - name: Copy files to the test website with the AWS CLI
      run: |
        aws s3 sync . s3://my-s3-test-website-bucket