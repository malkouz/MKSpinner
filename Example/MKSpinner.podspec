#
#  Be sure to run `pod spec lint MKSpinner.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name             = "MKSpinner"
s.version          = "1.1.0"
s.summary          = "A beautiful activity indicator written in Swift"
s.description      = <<-DESC
SwiftSpinner is an extra beautiful activity indicator with plain and bold style fitting iOS 8 design very well. It uses dynamic blur and translucency to overlay the current screen contents and display an activity indicator with text (or the so called “spinner”).
I developed it for my Swift app called **Doodle Doodle** (http://doodledoodle.io) and wanted to share it with everyone.
DESC
s.homepage         = "https://github.com/malkouz/MKSpinner"

s.license          = 'None'
s.author           = { "Moayad Al kouz" => "moayad_kouz9@hotmail.com" }
s.source           = { :git => "https://github.com/malkouz/MKSpinner.git", :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/icanzilb'

s.ios.deployment_target = '8.0'

s.requires_arc = true

s.source_files = '../MKSpinner/**/*'
s.frameworks = 'UIKit'

end
