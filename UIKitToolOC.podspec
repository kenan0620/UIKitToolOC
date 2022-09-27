#
# Be sure to run `pod lib lint UIKitToolOC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UIKitToolOC'
  s.version          = '0.2.2'
  s.summary          = 'UIKitToolOC 常用的组件库.'
  s.homepage         = 'https://github.com/kenan0620/UIKitToolOC'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kenan' => 'coenen@aliyun.com' }
  s.source           = { :git => 'https://github.com/kenan0620/UIKitToolOC.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.jianshu.com/u/aa2d07ae7c2f'
  s.ios.deployment_target = '11.0'
  s.source_files = 'UIKitToolOC/Classes/UIKitToolOC.h'

  s.subspec 'Adapt' do |ss|
      ss.source_files = 'UIKitToolOC/Classes/Adapt{*}.{h,m}'
  end
  
  s.subspec 'Network' do |ss|
      ss.source_files = 'Network'
      ss.dependency 'YTKNetwork'
  end
  
  s.subspec 'Pop' do |ss|
      ss.source_files = 'UIKitToolOC/Classes/Pop{*}.{h,m}'
      ss.dependency 'Masonry'
      ss.dependency 'CategoryToolOC/UIView'
  end
  
  s.subspec 'UILabel' do |ss|
      ss.source_files = 'UIKitToolOC/Classes/{*}Label.{h,m}'
  end
  
  s.subspec 'UIPickerView' do |ss|
      ss.source_files = 'UIKitToolOC/Classes/{*}Picker.{h,m}'
      ss.dependency 'Masonry'
      ss.dependency 'CategoryToolOC/Date'
      ss.dependency 'CategoryToolOC/UIColor'
      ss.dependency 'CategoryToolOC/UIFont'
  end
  
  s.subspec 'UISwitch' do |ss|
      ss.source_files =
      'UIKitToolOC/Classes/{*}Switch.{h,m}'
  end
  
  s.subspec 'UITextField' do |ss|
      ss.source_files =
      'UIKitToolOC/Classes/{*}TextField.{h,m}',
      'UIKitToolOC/Classes/Keyboard{*}.{h,m}'
      ss.dependency 'CategoryToolOC/UIImage'
      ss.resource = 'UIKitToolOC/Classes/KeyboardImage.bundle'

  end
  
end
