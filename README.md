# Docker container for load testing websites
This will run a low(5), medium(15) and high(25) load test for 3 minutes based off variable passed through at runtime.  Results are available in a /results folder.

Pass/Fail criteria:
average response time under Low Load of under 10s for 10s
average response time under Medium Load of under 20s for 20s
average response time under High Load of under 30s for 30s
any 400 error codes
any 500 error codes
100% success responses


# Step 1 : pull/start container
docker run -e test={https://qa-www.readytalk.com/blog} -v $(pwd)/results:/results --rm -it mstrenz/taurus-load

