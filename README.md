# DirectoryUploader
Monitors a directory and automatically detects new files added to it. Uploads all files to a target URL, and cleans up afterwards.

## Usage

```swift
let uploader = DirectoryUploader(sourceDirectory: docDir, targetURL: endpointURL)
// now save files to docDir, and they will be automatically uploaded to endpointURL.
```

To send the uploaded filename as a query parameter:

```swift
let uploader = DirectoryUploader(sourceDirectory: docDir, targetURL: endpointURL, filenameParameterName: "name")
```

## Installation

### CocoaPods:

```ruby
pod 'DirectoryUploader'
```

### Manually:

Copy `Sources/*` to your Xcode project.
