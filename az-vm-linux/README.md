# Linux VM using Azure

## To Connect
- Save private key to a pem file: 
    - `terraform output -raw private_key > private_key.pem && chmod 600 private_key.pem`
- Connect using pem file and username:
    - `ssh -i private_key.pem $(terraform output -raw user_name)@$(terraform output -raw public_ip_address)`

## Notes
- SSH Keypair generated using AzAPI provider, but this could have also been done using TLS locally.
- the original code on MS site tried to jsondecode public / private keys, which was not needed. simply removing the function call fixed the problem.

