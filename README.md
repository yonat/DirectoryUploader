# DirectoryUploader
Monitors a directory and automatically detects new files added to it. Uploads all files to a target URL, and cleans up afterwards.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/DirectoryUploader.svg)](https://img.shields.io/cocoapods/v/DirectoryUploader.svg)  
[![Platform](https://img.shields.io/cocoapods/p/DirectoryUploader.svg?style=flat)](http://cocoapods.org/pods/DirectoryUploader)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

## Installation

### CocoaPods:

```ruby
pod 'DirectoryUploader'
```

### Manually:

Copy `Sources/*` to your Xcode project.

## Usage

```swift
let uploader = DirectoryUploader(sourceDirectory: docDir, targetURL: endpointURL)
// now save files to docDir, and they will be automatically uploaded to endpointURL.
```

## Meta

[@yonatsharon](https://twitter.com/yonatsharon)

[https://github.com/yonat/DirectoryUploader](https://github.com/yonat/DirectoryUploader)

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE.txt
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
