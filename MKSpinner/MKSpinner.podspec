#
#  Be sure to run `pod spec lint MKSpinner.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  These will help people to find your library, and whilst it
#  can feel like a chore to fill in it's definitely to your advantage. The
#  summary should be tweet-length, and the description more in depth.
#

s.name         = "MKSpinner"
s.version      = "1.3.1"
s.summary      = "Beautiful activity indicator."

s.description  = "Beautiful activity indicator. Same of SwiftSpinner with changed animation (https://github.com/icanzilb/SwiftSpinner)"

s.homepage     = "https://github.com/malkouz/MKSpinner"

s.license      = "MIT"


s.author             =  "Moayad Al kouz"
# s.social_media_url   = "http://twitter.com/malkouz"


s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/malkouz/MKSpinner.git", :tag => "#{s.version}" }


s.source_files  = "Classes", "Classes/*"
s.exclude_files = "Classes/Exclude"


end
