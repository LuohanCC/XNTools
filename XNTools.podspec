#
# Be sure to run `pod lib lint XNTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'XNTools'
    s.version          = '2.0.2'
    s.summary          = 'create XNTools by luohan'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here1.
    DESC
    
    s.homepage         = 'https://github.com/LuohanCC'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '罗函' => 'luohancc@163.com' }
    s.source           = { :git => 'https://github.com/LuohanCC/XNTools.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '9.0'
    
    s.source_files = 'XNTools/Classes/**/*.{h,m}'

    s.subspec 'Utils' do |s4|
      s4.source_files = 'XNTools/Classes/Utils/**/*'
    end
    
    s.subspec 'Views' do |ss|
      ss.source_files = 'XNTools/Classes/Views/**/*'
      ss.dependency 'Masonry'
      ss.dependency 'XNProgressHUD'
    end

#     s.subspec 'UIViewExtension' do |ss|
#        ss.source_files = 'XNTools/Classes/UIViewExtension/**/*'
#        ss.requires_arc = true
#    end
#
#    s.subspec 'ViewController' do |ss|
#        ss.source_files = 'XNTools/Classes/ViewController/**/*'
#        ss.requires_arc = true
#    end
#
    
#
##
#    s.xcconfig = { "FRAMEWORK_SEARCH_PATHS" => "$(PLATFORM_DIR)/Developer/Library/Frameworks" }

#
    # ------ 资源（图片、Xib、其他Bundle） ------
    s.resource_bundles = {
        'XNTools' => ['XNTools/Assets/**/*']
    }
    
    #s.dependency 'YYKit'
    s.dependency 'Masonry'
    s.dependency 'MJRefresh'
    s.dependency 'SDWebImage'
    s.dependency 'AFNetworking'
    s.dependency 'XNProgressHUD'
    
    s.swift_version='4.0'
    
    # ------ 平台支持 ------
    valid_archs = ['arm64', 'armv7', 'armv7s']
    
    
    #s.vendored_frameworks = 'Pod/**/*.framework'
    
    # ------ 声明所依赖的库，如果不指定，引入者将会找不到文件 ------
    #s.public_header_files = 'XNUtils&XNUserDefaults/XNConf'
    s.frameworks = 'UIKit', 'AVFoundation'
    s.libraries = 'c++','resolv'
    
end
