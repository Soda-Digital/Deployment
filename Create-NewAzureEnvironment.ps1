
# Inputs needed

# Customer tenant
# Subscription Id
# Client Name


# Create the Azure resources in our tenant:

# * Security Group  - “{Client Name} (Azure Contributor)” 
# * Service Principal  - ClientName (Service Operations)
# * Add this service principal (SP) to the above group
# * Setup federated credentials against the above SP

# * Login to customer tenant az login --tenant TENANT_ID
# * Create a SP in their tenant - az ad sp create-for-rbac -n "<Client Name> (Soda Digital Client Operations)"
# * Note the password created and store in 1pass.
# * Assign this SP the owner role - az role assignment create --assignee "<object Id of the above created user> " --role "Owner" --scope "/subscriptions/<subscription id>"
 
# Step 2 Azure Lighthourse - TODO, come back to this

