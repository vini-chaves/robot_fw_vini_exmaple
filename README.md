# Robot Framework - Example script to future reference on other tasks

I made this repository to be a reference material to other future projects if needed

## How to call robot 
---------------
#### To run all TC
-  robot -d ./Reports ./TestCases/TC2.robot

#### To run just a single named test case
-  robot -L Trace -d ./Reports -t TestElements02 ./TestCases/TC2.robot

#### To run all test cases with a specific tag
-  robot -d ./Reports -i PerformActions ./TestCases/TC2.robot

#### To run a test case setting a variable
-  robot -d ./Reports -t TestElements02 -v variable_name:value ./TestCases/TC2.robot

+ more info at the excel file available on the root directory (Robot-Framework-Options.xlsx)
---------------
#### To run more than one process at the same time (Parallel Tests)
-  need to install pabot (pip install -U robotframework-pabot) [available on requirements.txt]
-  pabot --processes 4 -d ./Reports ./TestCases/*.robot
#### To run parallel test cases instead of test suites
-  pabot --testlevelsplit -d ./Reports ./TestCases/TC2.robot 

+  more info at: https://github.com/mkorpela/pabot 

