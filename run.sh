#!/usr/bin/env bash

read -p "Xcode app path: " xcodeAppPath

# App path not exist.
if [ ! -d "$xcodeAppPath" ]
then
    echo "$xcodeAppPath not exist."
    exit 0
fi

# Not Xcode app path.
if [ ! -f "$xcodeAppPath/Contents/info.plist" ]
then
    echo "$xcodeAppPath/Contents/info.plist not exist."
    exit 0
fi

bundleName=$(/usr/libexec/PlistBuddy -c "Print CFBundleName" $xcodeAppPath/Contents/info.plist)
if [ $bundleName != "Xcode" ]
then
    echo "$xcodeAppPath is not a valid Xcode app path."
    exit 0
fi

# Xcode version
if [ ! -f "$xcodeAppPath/Contents/version.plist" ]
then
    echo "$xcodeAppPath/Contents/version.plist not exist."
    exit 0
fi

xcodeVersion=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $xcodeAppPath/Contents/version.plist)
echo "Detected Xcode version is: $xcodeVersion"

# Download and unzip files
curl --retry 2 -o libstdc++.zip https://codeload.github.com/JJAYCHEN1e/Bring-libstdcpp-back-to-Xcode/zip/master

unzip libstdc++.zip > /dev/null 

# Copy files
if [ $(echo "$xcodeVersion >= 11.0" | bc) == "1" ]
then
	sudo cp ./Bring-libstdcpp-back-to-Xcode-master/CoreSimulator/libstdc++.dylib $xcodeAppPath/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib
    sudo cp ./Bring-libstdcpp-back-to-Xcode-master/CoreSimulator/libstdc++.6.dylib $xcodeAppPath/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib
    sudo cp ./Bring-libstdcpp-back-to-Xcode-master/CoreSimulator/libstdc++.6.0.9.dylib $xcodeAppPath/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib
else
    sudo cp ./Bring-libstdcpp-back-to-Xcode-master/CoreSimulator/libstdc++.dylib $xcodeAppPath/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/
    sudo cp ./Bring-libstdcpp-back-to-Xcode-master/CoreSimulator/libstdc++.6.dylib $xcodeAppPath/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/
    sudo cp ./Bring-libstdcpp-back-to-Xcode-master/CoreSimulator/libstdc++.6.0.9.dylib $xcodeAppPath/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/
fi

sudo cp ./Bring-libstdcpp-back-to-Xcode-master/MacOSX.platform/libstdc++.tbd $xcodeAppPath/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib/
sudo cp ./Bring-libstdcpp-back-to-Xcode-master/MacOSX.platform/libstdc++.6.tbd $xcodeAppPath/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib/
sudo cp ./Bring-libstdcpp-back-to-Xcode-master/MacOSX.platform/libstdc++.6.0.9.tbd $xcodeAppPath/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/lib/

sudo cp ./Bring-libstdcpp-back-to-Xcode-master/iPhoneOS.platform/libstdc++.tbd $xcodeAppPath/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib/
sudo cp ./Bring-libstdcpp-back-to-Xcode-master/iPhoneOS.platform/libstdc++.6.tbd $xcodeAppPath/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib/
sudo cp ./Bring-libstdcpp-back-to-Xcode-master/iPhoneOS.platform/libstdc++.6.0.9.tbd $xcodeAppPath/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib/

sudo cp ./Bring-libstdcpp-back-to-Xcode-master/iPhoneSimulator.platform/libstdc++.tbd $xcodeAppPath/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib/
sudo cp ./Bring-libstdcpp-back-to-Xcode-master/iPhoneSimulator.platform/libstdc++.6.tbd $xcodeAppPath/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib/
sudo cp ./Bring-libstdcpp-back-to-Xcode-master/iPhoneSimulator.platform/libstdc++.6.0.9.tbd $xcodeAppPath/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib/

# Clean
sudo rm ./libstdc++.zip
sudo rm -rf ./Bring-libstdcpp-back-to-Xcode-master



