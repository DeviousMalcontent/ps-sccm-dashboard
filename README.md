# ps-sccm-dashboard
Dashboard written in PowerShell that provides up-to-date information taken from the SCCM server on client computer groups (or collections)

A Demo of the Dashboard can be seen at this link:
http://deviousmalcontent.github.io/demos/ps-sccm-dashboard/dashboard_demo.html

This dashboard is designed to be shown on a portrait orientated display (i.e. a monitor on its side.)

## Directory structure

**/ps/** - PowerShell version

**/exe/** - Standalone, self-hosted executable written in Masm32

**/php/** - PHP version

### PowerShell version
- The script needs to be run as Administrator

- The script will prompt you with a UAC prompt in order to start the server, this is required to run the system.net.httplistener component, in the future, I will add an option or documentation to allow the user to grant permissions to the particular URLs used by the script. 

- The script is not yet signed, you will need to run StartServer.vbs by double clicking on it in Windows, this runs the script with the bypass execution policy flag enabled. – USE AT OWN RISK

- This script is based on the example provided by Peter Hinchley, and the original script can be found at the following web link: 
https://hinchley.net/articles/create-a-web-server-using-powershell/

#### TODO:

- Add code: Defaults if no settings file is found

- Advanced formatting for the dashboard, i.e. display a row in red if a client is listed with an outdated OS build or outdated client.

- Add code: for if there is only one device collection listed there is no need to run the carousel, there is also no need to show the progress bar

- Setting variables that need to be implemented:
deviceCollectionsAttributes, deviceCollectionsReferenceSystemHost, carouselInterval, dashboardRefreshRate.

#### Known bugs:

- The carousel data-interval and the progress-bar seem to fall out of sync and do not always match up 

- The carousel data-interval and the progress-bar also do not seem to pulse at the same interval, i.e. for the moment they are set to 20 seconds, but using any other setting, one may pulse at a higher interval,

- I have also noted some bugs when messing around with the progress-bar, not attached to the carousel, but the carousel speeds up for some reason. 

- This is an issue that needs to be fixed in the dashboard_template.html found under the design directory of this repo, once fixed there, it can be reimplemented back into this script. 
