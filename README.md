# Wall-Of-Fame


## Introduction:

This is a simple app that retrieves the top stared repos on github created the last 30 days.


## How to run:

- To use this app you should run it using Xcode.
- Open the .xcworkspace.
- Select the Wall of Fame project on the top left in the navigator.
- Select the Target and change the team and bundle identifier to be able to run it on your device.
- Run the project.

## Implemented:
- Loading repos.
- Handling network down.
- Displaying empty state when needed.
- Retrying on failure.
- Handeling different responses.
- Unit Test for the ViewModel


## Libraries:
- OHHTTPStubs/Swift: Used to Stub the network calls in test to give the option to choose the response tests (200,404 ...) without using the real network.