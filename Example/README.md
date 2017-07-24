Zoom Service Sample App
===============

This sample app is meant to show how Zoom Service can be used to allow users to quickly start and join calls through Zoom in an app.

1. [Dependencies](#dependencies)
2. [API Setup](#api-setup)

# Dependencies

## MobileRTC
**OS X users have the option to execute the `zoom.sh` script to skip this step. Just use terminal to navigate to the app directory and execute the script.**

For users who want to install MobileRTC manually, download the [MobileRTC stack](http://hybridupdate.zoom.us/latest/rtc/iOS-MobileRTC-Stack-with-Device-only-framework-master.zip) and unzip the file after it is downloaded. Copy the contents of the `/lib/` folder from the uncompressed `zoom-ios-mobilertc` folder into the app directory `/lib/` and delete `zoom-ios-mobilertc.zip` as well as the uncompressed folder.

# API setup
Open up Xcode and launch the sample app. Navigate to `ZoomService.swift`. We need to fill in the data required by the ZoomAPI struct.

## MobileRTC Authentication
If you haven't already, [sign up](https://zoom.us/developer) for a Zoom Developer account which provides access to the Zoom REST API, Desktop SDKs, and most importantly, the MobileRTC stacks.

Choose the iOS MobileRTC Stack option once you have signed in, and under the credential tab, copy the APP Key and APP Secret into the `appKey` and `appSecret` into the `ZoomAPI` struct. The direct link to the credentials page can be found [here](https://zoom.us/developer/ios/credential).

## Zoom API Authentication
While signed in to the Zoom developer website, navigate to the [REST API playground](https://zoom.us/developer/api/playground) page. Note that your REST API credentials in the credentials tab and your MobileRTC credentials from earlier are **NOT** the same. On the playground page, change the `API Endpoint` to `https://api.zoom.us/v1/user/getbyemail` and the `User Email Address` to the email you used to create your Zoom developer account.

Press the `Send API Request` and scroll down until you see the `Response` array. Copy the value for `id` and `token` and paste them as the `userID` and `userToken` strings in the `ZoomAPI` struct respectively.

**That's it! Compile the app and test it out!**

If you want to create your own app using Zoom's MobileRTC SDK, I've written a [full guide](https://github.com/george-lim/zoom-sdk-guide) to help you build your app from scratch.