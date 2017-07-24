Zoom Service
<br>
![GitHub downloads](https://img.shields.io/github/downloads/george-lim/zoom-service/total.svg)
[![GitHub release](https://img.shields.io/github/release/george-lim/zoom-service.svg)](https://github.com/george-lim/zoom-service/releases)
[![GitHub issues](https://img.shields.io/github/issues/george-lim/zoom-service.svg)](https://github.com/george-lim/zoom-service/issues)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/george-lim/zoom-service.svg)](https://github.com/george-lim/zoom-service/pulls)
[![license](https://img.shields.io/github/license/george-lim/zoom-service.svg)](https://github.com/george-lim/zoom-service/blob/master/LICENSE)
===============

This project tries to make integrations with the [Zoom SDK](https://zoom.us/developer) on Swift easier by providing all the properly configured functions for the user to use with their project.

1. [Installation](#installation)
1. [Usage](#usage)

# Installation

## Basics
**Download the `ZoomService.swift` file and add it to your app manually.** Zoom Service currently utilizes the [singleton pattern](https://sourcemaking.com/design_patterns/singleton), so it can be referenced from anywhere in your app.

Your app must first already have MobileRTC installed. For instructions on how to install MobileRTC into your app, follow my [Zoom MobileRTC guide](https://github.com/george-lim/zoom-sdk-guide).

## Example App
There is an example app provided with Zoom Service already integrated. Feel free to first explore Zoom Service through the example app before integrating it into your own app. Please read the `README.md` inside the example app before compiling.

# Usage
Open up Xcode and launch the sample app. Navigate to `ZoomService.swift`. You need to fill in the data required by the ZoomAPI struct.

## MobileRTC Authentication
If you haven't already, [sign up](https://zoom.us/developer) for a Zoom Developer account which provides access to the Zoom REST API, Desktop SDKs, and most importantly, the MobileRTC stacks.

Choose the iOS MobileRTC Stack option once you have signed in, and under the credential tab, copy the APP Key and APP Secret into the `appKey` and `appSecret` into the `ZoomAPI` struct. The direct link to the credentials page is found [here](https://zoom.us/developer/ios/credential).

Finally, in your `AppDelegate.swift` file, add the line `ZoomService.sharedInstance.authenticateSDK()` in your `didFinishLaunchingWithOptions` function and you should be set.

**Note: The APP Key and APP Secret are your credentials to authorize your use of the MobileRTC framework in your app. As of now, you still cannot start or join calls with Zoom Service until you are authorized as a Zoom API user or a Zoom member.**

## Zoom Authentication
In order to use Zoom, the app must first authenticate itself as an API user. Afterward, if you would like to have users authenticate themselves through their Zoom accounts, they can optionally sign in and Zoom authenticate the user as well.

**Zoom API Authentication (Required)**
If your app requires the capability to start or create calls without the user signing in, you first need to obtain the API `userID` and `userToken` values.

Sign in to the Zoom developer site again and navigate to the [REST API playground](https://zoom.us/developer/api/playground) page. Note that your REST API credentials in the credentials tab and your MobileRTC credentials from earlier are **NOT** the same. On the playground page, change the `API Endpoint` to `https://api.zoom.us/v1/user/getbyemail` and the `User Email Address` to your email you used to create your Zoom developer account.

Press the `Send API Request` and scroll down until you see the `Response` array. Copy the value for `id` and `token` and paste them as the `userID` and `userToken` strings in the `ZoomAPI` struct respectively.

What we are doing is sending a REST API call through the Zoom developer REST API service to fetch our API ID and token values as if we are an API user. Using this data, we can authorize ourselves in our app as an API user.

**Zoom Member Authentication (Optional)**
To authenticate the user as a Zoom member, you are required to implement your own app flow to retrieve the user's username and password values. After you have received them, call the `ZoomService.sharedInstance.login(email: String, password: String)` function in your code to authenticate the user.

## Starting / Joining calls
**These 2 features are available to both authentication types.** Please note that API authenticated users can only utilize these 2 core functions in the MobileRTC Stack. This means that scheduling calls ahead of time is **IMPOSSIBLE** for an API user without using a separate Zoom REST API call which is outside the scope of MobileRTC. So to clarify, API authenticated users can only start a call (immediately) or join a call.

To join a call, simply execute `ZoomService.sharedInstance.joinMeeting(number: String = ZoomAPI.defaultName, password: String = "")` in your code. Neither parameter is required. The MobileRTC framework will then take over and present a view on top of your app which will launch the call.

Likewise, to start a call, simply execute `ZoomService.sharedInstance.startMeeting(name: String = ZoomAPI.defaultName, number: Int = -1, password: String = "")` in your code. If you specify a meeting number, Zoom Service will attempt to create a call for the number specified, and will return an error if someone is already using the meeting number. None of the parameters are required.

## Meeting Scheduling / User Account Management

**The following list of functions are exclusive to users who have signed in to their own Zoom accounts in your app. Zoom's SDK does not allow API users to schedule, edit, or delete meetings. To accomplish this, refer to Zoom's REST API usage.** 

`func scheduleMeeting(topic: String, startTime: Date, timeZone: TimeZone = NSTimeZone.local, durationInMinutes: TimeInterval)` - schedules a meeting ahead of time.

**Note: the following functions require the user to have permission to edit the specified meeting. Otherwise, the functions will return an error.**

`func editMeeting(_ zoomMeeting: ZoomMeeting, topic: String? = nil, startTime: Date? = nil, timeZone: TimeZone? = nil, durationInMinutes: TimeInterval? = nil)` - edits an existing Zoom meeting by ZoomMeeting reference.

`func editMeeting(number: Int, topic: String? = nil, startTime: Date? = nil, timeZone: TimeZone? = nil, durationInMinutes: TimeInterval? = nil)` - edits an existing Zoom meeting by meeting number.

`func deleteMeeting(_ zoomMeeting: ZoomMeeting)` - deletes an existing Zoom meeting by ZoomMeeting reference.

`func deleteMeeting(number: Int)` - deletes an existing Zoom meeting by meeting number.
