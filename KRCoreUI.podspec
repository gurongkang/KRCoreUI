#
#  Be sure to run `pod spec lint KRDrawLineSpec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "KRCoreUI"
  s.version      = "1.1.0"
  s.summary      = "KRCoreUI"
  s.description  = "常见核心组件封装"
  s.homepage     = "https://github.com/gurongkang"
  s.license      = "MIT"
  s.author       = { "gurongkang" => "1530669303@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/gurongkang/KRCoreUI", :tag => "#{s.version}"}
  s.source_files = "Classes", "KRCoreUI/Classes/**/*.{h,m}"
end
