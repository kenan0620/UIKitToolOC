#
# Be sure to run `pod lib lint UIKitToolOC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UIKitToolOC'
  s.version          = '0.1.2'
  s.summary          = 'UIKitToolOC 常用的组件库.'
  s.homepage         = 'https://github.com/kenan0620/UIKitToolOC'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kenan' => 'coenen@aliyun.com' }
  s.source           = { :git => 'https://github.com/kenan0620/UIKitToolOC.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.jianshu.com/u/aa2d07ae7c2f'
  s.ios.deployment_target = '11.0'
  s.source_files = 'UIKitToolOC/Classes/UIKitToolOC.h'

  s.subspec 'Adapt' do |ss|
      ss.ios.deployment_target = '11.0'
      ss.source_files = 'UIKitToolOC/Classes/Adapt{*}.{h,m}'
  end
  
  s.subspec 'UITextField' do |ss|
      ss.ios.deployment_target = '11.0'
      ss.source_files = 'UIKitToolOC/Classes/{*}TextField.{h,m}'
  end
  
  s.subspec 'Pop' do |ss|
      ss.ios.deployment_target = '11.0'
      ss.source_files = 'UIKitToolOC/Classes/Pop{*}.{h,m}'
      ss.dependency 'Masonry'
      ss.dependency 'CategoryToolOC/UIView'
  end
  
end
