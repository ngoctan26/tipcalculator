# Pre-work - TipCalculator

TipCalculator is a tip calculator application for iOS.

Submitted by: Nguyen Quang Ngoc Tan

Time spent: 96 hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] User can enable or disable alert function. An alert will be shown when the amount of money for tip is over expectation. The limitaion can be configuration by User in Setting menu

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/rI32EDo.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

+Adaptive layout is a challenge. I try auto-layout to make app more responsive with different device size. However it seem not enough, I can not manage to make it adapt with all devices
+Table view and multiple sections also make me get some trouble to completely implement it in SettingView

## License

Copyright 2017 Nguyen Quang Ngoc Tan

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
