#
# Be sure to run `pod lib lint XNTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'XNTools'
    s.version          = '2.0.1'
    s.summary          = 'create XNTools by luohan'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here1.
    DESC
    
    s.homepage         = 'https://gitee.com/luohancc/XNTools.git'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '罗函' => 'luohancc@163.com' }
    s.source           = { :git => 'https://gitee.com/luohancc/XNTools.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    
    #s.source_files = 'XNTools/Classes/**/*'
    # ------ 文件夹(调用者能看到的文件夹) ------
    
    #XNTools
    s.source_files = 'XNTools/Classes/*.h'
    
    #XNViewController
    s.subspec 'XNViewController' do |ss|
        ss.source_files = 'XNTools/Classes/XNViewController/**/*'
    end
    
    #XNViews
    s.subspec 'XNViews' do |ss|
        ss.source_files = 'XNTools/Classes/XNViews/**/*'
    end
    
    #XNUtils
    s.subspec 'XNUtils' do |ss|
        ss.source_files = 'XNTools/Classes/XNUtils/**/*'
    end
    
    #XNUIVIewExtension
    s.subspec 'XNUIVIewExtension' do |ss|
        ss.source_files = 'XNTools/Classes/XNUIVIewExtension/**/*'
    end
    
#    #XNAFNHelper
#    s.subspec 'XNAFNHelper' do |ss|
#        ss.source_files = 'XNTools/Classes/XNAFNHelper/**/*'
#    end
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
    s.dependency 'lottie-ios'
    
    # ------ 平台支持 ------
    valid_archs = ['arm64', 'armv7', 'armv7s']
    
    
    #s.vendored_frameworks = 'Pod/**/*.framework'
    
    # ------ 声明所依赖的库，如果不指定，引入者将会找不到文件 ------
    #s.public_header_files = 'XNUtils&XNUserDefaults/XNConf'
    s.frameworks = 'UIKit', 'AVFoundation'
    s.libraries = 'c++','resolv'
    
end
