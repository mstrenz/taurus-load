# Docker container for load testing websites
This will run a test against a website based off the config in site_test.yml

Pass/Fail criteria:
average response time of under 50ms for 30s
any 400 error codes
any 500 error codes


# Step 1 : pull/start container
docker run --it --name taurus-load mstrenz/taurus-load
