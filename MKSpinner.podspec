#
# Be sure to run `pod lib lint MKSpinner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKSpinner'
  s.version          = '0.1.0'
  s.summary          = 'MKSpinner. is an extra beautiful two activity indicators with plain and bold style fitting iOS 8 design very well. "MKFullSpinner" is used for indicator with full screen background, another one called "MKNSpinner" is an indicator with mini background(not full screen) '

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/malkouz/MKSpinner'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Moayad Al kouz' => 'moayad_kouz9@hotmail.com' }
  s.source           = { :git => 'https://github.com/malkouz/MKSpinner.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MKSpinner/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MKSpinner' => ['MKSpinner/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
