# qiscus-sdk-ios-sample-v2

Qiscus SDK iOS Sample v2

Other sample app you can see at here: [Qiscus SDK iOS](https://github.com/qiscus/qiscus-sdk-ios-sample) 

## Build Setup
To run this app, first you should already installed [Cocoapods](http://cocoadocs.org) and then run this command at your terminal
``` bash
# install dependencies
pod install

```

## Features
Some features that available:
- [x] Splash/Launch Screen
- [x] Login
- [x] Random user avatar
- [x] Room List
- [x] Contact List
- [x] Create New Chat
  - [x] Chat with Stranger
  - [x] Create Group
    - [x] Select Participant
    - [x] Add Group Info
- [x] Group Info
- [x] Contact Info
- [x] Setting


## Screen Shots
You can see some available features in this project like below:

#### Create Group
Create New Chat → Create Group → Select participants → Input group name → Choose image group

![create_group_1](http://res.cloudinary.com/rohmadst/image/upload/v1511711195/ios-sample-app/chat-sdk/create-group-part-1.gif)
![create_group_2](http://res.cloudinary.com/rohmadst/image/upload/v1511711237/ios-sample-app/chat-sdk/create-group-part-2.gif)


#### Group Info
Open group chat → Click header chat

![group_info](http://res.cloudinary.com/rohmadst/image/upload/q_43/v1511709883/ios-sample-app/chat-sdk/group-info.gif)


#### Chat with Stranger
Create New Chat → Chat With Stranger → Input Unique Id of target user (e.g.: email, username, or unique id else)

![chat_with_stranger](http://res.cloudinary.com/rohmadst/image/upload/v1511711193/ios-sample-app/chat-sdk/chat-with-stranger.gif)


#### Contact Info
Open Contact → Click Contact → Contact Detail

![contact_info](http://res.cloudinary.com/rohmadst/image/upload/v1511709877/ios-sample-app/chat-sdk/contact-info.gif)

## Try Qiscus IOS Sample App
If you simply want to try the IOS sample app, you can direct to our [github repository](https://github.com/qiscus/qiscus-sdk-web-sample) to clone our sample app. You can explore features of Qiscus Chat SDK.

If you are willing to change your own App ID, Contacts URL, or other else. You can change it in **Helper.swift** file. Here is how it will look like:
```swift
...

class Helper: NSObject {
    static var APP_ID: String {
        get {
            return "YOUR_APP_ID"
        }
    }

    static var BASE_URL: String {
        get {
            return "https://dashboard-sample.herokuapp.com" // CHANGE THIS WITH YOUR OWN URL
        }
    }
    ...
```
