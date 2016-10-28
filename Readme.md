
Simple tools to build and push Nuxeo to CF / PWS.

### Content

`build.sh`
Download, unzip and pre-configure a Nuxeo Server.

`manifest_template.yml`
Template used to the cf application manifest.

### Run

Define the environment variable `CF_PWD` with your CF/PWS password.

Edit variables in `build.sh` to match 

 - the target nuxeo configuration 
 - your CF settings (like `CF_LOGIN`)

Run the build:

    ./build.sh







