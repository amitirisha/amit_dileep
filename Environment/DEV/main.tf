
## module for creating Azure Resource Groups
module "resourceblock" {
source ="../../modules/azurerm_resource_group"
resource_groups = var.resourcevalue   
  
}

## module for creating Azure Virtual Network
module "vnetblock" {
    depends_on = [ module.resourceblock ]
    source = "../../modules/azurerm_virtual_Network"
    vspace = var.vspacevalue
} 

## module for creating Azure Subnet

module "subnetblock" {
    depends_on = [ module.vnetblock, module.resourceblock ]
    source = "../../modules/azurerm_virtual_subnet"
    subnet = var.subnetvalue
  
}
## module for creating Azure Virtual Machine

module "virtual_Machine_block" {
    depends_on = [ module.subnetblock, module.vnetblock, module.resourceblock ]
    source = "../../modules/azurerm_virtual_machine"
    vm_details = var.vmvalue
  
}

## module for creating Azure Bastion Host
module "bastionblock" {
    depends_on = [ module.subnetblock, module.vnetblock, module.resourceblock ]
    source = "../../modules/azurerm_bastion"
    bastionvalue = var.bastionvalue1
}
##module for creating Azure NAT Gateway    
module "nat_gateway_block" {
    depends_on = [ module.subnetblock, module.vnetblock, module.resourceblock ]
    source              = "../../modules/azurerm_nat_gateway"
    nat_value           = var.nat_gateway_value
}
##module for craeting Azure Network Security Group
module "security_group_block" {
    depends_on = [ module.subnetblock, module.vnetblock, module.resourceblock ]
    source = "../../modules/azurerm_security_group"
    powersecurity = var.powersecurity
}