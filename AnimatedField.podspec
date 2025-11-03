#
# Be sure to run `pod lib lint AnimatedField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    
# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.platform = :ios
s.ios.deployment_target = '16.0'
s.name              = 'AnimatedField'
s.summary           = 'Enhanced AnimatedField: Swift 6, accessibility, zero crashes - Modern animated text fields with validation'
s.description       = 'Enhanced fork with Swift 6 support, VoiceOver accessibility, zero force unwraps, and comprehensive improvements. Animated UITextField/UITextView with validation using regular expressions for common types (email, url, password, price, date). Thread-safe and App Store compliant.'
s.version           = '3.0.0'

# ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.license           = { :type => 'MIT', :file => 'LICENSE' }

# ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.author            = { 'Alberto Aznar' => 'info@alberdev.com', 'DoubleNode' => 'support@doublenode.com' }
s.homepage          = 'https://github.com/DoubleNodeOpen/AnimatedField'
s.social_media_url  = 'https://twitter.com/alberdev'

# ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.source            = { :git => 'https://github.com/DoubleNodeOpen/AnimatedField.git', :tag => s.version.to_s }

# ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.framework         = 'UIKit'

# ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.source_files      = 'AnimatedField/**/*'

# ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

# s.resources         = 'AnimatedField/Resources/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}'

# ――― Swift Version ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

s.swift_version     = '6.0'

s.dependency "SwiftMaskTextfield"

end
