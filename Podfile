platform :ios, '8.0'
use_frameworks!

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        end
    end
end


target 'DBBrowser' do
    pod 'MBProgressHUD'
    pod 'MJExtension'
    pod 'YTKNetwork'
    pod 'MJRefresh'
    pod 'ReactiveObjC'
    pod 'IQKeyboardManager'
    pod 'SDWebImage'
    pod 'Masonry'
    #文件压缩,解压
    pod 'SSZipArchive'

end


