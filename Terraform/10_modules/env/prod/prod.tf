module "prod" {
    source              = "../../aks"
    rg_name             = "nextopsprodaksrg"
    rg_location         = "westus"
    acr_name            = "nextopsprodacrt34"
    acr_sku             = "Premium"
    aks_name            = "nextopsprodakst34"
    aks_dns_prefix      = "nextopsprod"
    aks_node_count      = "3"
    aks_node_vm_size    = "Standard_A2_v2"
    aks_env             = "prod"  
}