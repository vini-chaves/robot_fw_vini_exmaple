### How to call robot 
#### To run all TC
robot -d ./Reports ./TestCases/TC2.robot

#### To run just a single named test case
robot -L Trace -d ./Reports -t TestElements02 ./TestCases/TC2.robot

#### To run all test cases with a specific tag
robot -d ./Reports -i PerformActions ./TestCases/TC2.robot

#### To run a test case seting a variable
robot -d ./Reports -t TestElements02 -v variable_name:value ./TestCases/TC2.robot
