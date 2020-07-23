# Bring libstdcpp back to Xcode
 
When compiling with Xcode 10 or later, we got an error: `library not found for -lstdc++.6.0.9`. The reason is that Apple uses libc++ instead of libstdc++ in Xcode 10 or later. But many third-party libraries still uses libstdc++, the easiest way to compile our project is manually bring libstdc++ back to Xcode. So I provide a shell script that can automatically add libstdc++ to your Xcode.

By the way, the CoreSimulator directory is changed in Xcode 11 or later, so I've add a special judge in the script.

For more detail:

> CoreSimulator directory in Xcode 10:
> `/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/`
> 
> CoreSimulator directory in Xcode 11 or later:
> `/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib`
>
> Other directories in Xcode 10 or later:
> `/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib/`
>
> `/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib/`
> 
> `/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib/`


## How to run?
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JJAYCHEN1e/Bring-libstdcpp-back-to-Xcode/master/run.sh)"
```
And then you should follow the hint, provide your Xcode.app path, like `/Applications/Xcode.app` or `/Applications/Xcode-beta.app` (Because as a developer, it's common to have various versions of Xcode app...). Everything else is done automatically.
