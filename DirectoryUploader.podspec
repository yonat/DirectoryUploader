
Pod::Spec.new do |s|

  s.name         = "DirectoryUploader"
  s.version      = "1.0.1"
  s.summary      = "Automatically upload all files saved in source directory, and then delete the uploaded files."

  s.description  = <<-DESC
Monitors a directory and automatically detects new files added to it. Uploads all files to a target URL, and cleans up afterwards.

Usage:

```swift
let uploader = DirectoryUploader(sourceDirectory: docDir, targetURL: endpointURL)
// now save files to docDir, and they will be automatically uploaded to endpointURL.
```
                   DESC

  s.homepage     = "https://github.com/yonat/DirectoryUploader"

  s.license      = { :type => "MIT", :file => "LICENSE.txt" }

  s.author             = { "Yonat Sharon" => "yonat@ootips.org" }
  s.social_media_url   = "http://twitter.com/yonatsharon"

  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/yonat/DirectoryUploader.git", :tag => s.version }

  s.source_files  = "Sources/*.swift"

  s.dependency 'iMonitorMyFiles'
end
