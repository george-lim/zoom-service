curl -O http://hybridupdate.zoom.us/latest/rtc/iOS-MobileRTC-Stack-with-Device-only-framework-master.zip
unzip iOS-RTC-Stack-master.zip
rm iOS-RTC-Stack-master.zip
mkdir -p lib
mv zoom-ios-mobilertc/lib/* ./lib
rm -R zoom-ios-mobilertc