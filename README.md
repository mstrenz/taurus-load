# Docker container for load testing websites
This will run a load test with env variables of url(https://qa-www.readytalk.com/blog), users(5), and length(60s).  Results are available in a /testResults/loadResults folder.

# Pass/Fail criteria:
average response time under load of under 10s for 10s
any 400 error codes
any 500 error codes
100% success responses


# Step 1 : pull/start container
docker run -e url=https://qa-www.readytalk.com/blog -e users=5 -e length=1m -v $(pwd)/testResults/loadResults:/results --rm -it mstrenz/taurus-load:latest

