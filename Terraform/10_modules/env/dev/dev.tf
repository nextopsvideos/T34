module "dev" {
    source              = "../../aks"
    rg_name             = "nextopsdevaksrg"
    rg_location         = "eastus"
    acr_name            = "nextopsdevacrt34"
    acr_sku             = "Basic"
    aks_name            = "nextopsdevakst34"
    aks_dns_prefix      = "nextopsdev"
    aks_node_count      = "1"
    aks_node_vm_size    = "Standard_A2_v2"
    aks_env             = "dev"  
}