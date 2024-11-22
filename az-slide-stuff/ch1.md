
AZ CLI commands to create, modify, delete a VM
```bash
az group create --name demo-rg --location "centralus"
az vm create -g demo-rg -n demo-vm --image Ubuntu2204 --size Standard_B1s
az vm stop -g demo-rg -n demo-vm
az vm resize -g demo-rg -n demo-vm --size Standard_B2s
az vm start -g demo-rg -n demo-vm
az vm delete -g demo-rg -n demo-vm --yes
az group delete -n demo-rg 
```