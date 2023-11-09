# 0. Format
tofu -chdir=src fmt
# 1. Apply
tofu -chdir=src apply --auto-approve
# 2. Test
tofu -chdir=src output -raw cloudinitfile > testfile
sudo cloud-init schema --config-file testfile --annotate
# 3. Test
./tests/validate_yaml.py testfile