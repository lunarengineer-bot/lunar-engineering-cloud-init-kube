# 1. Apply
tofu -chdir=src apply --auto-approve
# 2. Test
tofu -chdir=src output -raw stupid > stupidfile
sudo cloud-init schema --config-file stupidfile