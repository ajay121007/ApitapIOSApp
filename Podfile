# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
#use_frameworks!

target 'ApiTap' do
    # use_frameworks!
    pod 'MFSideMenu', '~> 0.5'
    #pod 'AFNetworking', '~> 3.0'
    pod 'SDWebImage', '~> 3.7'
    #pod 'GUITabPagerViewController', '~> 0.0.8'
    pod 'ASIHTTPRequest'
    pod 'SDWebImage', '~> 3.7'
    pod 'SVProgressHUD'
    pod "PPSSignatureView"
    pod 'AFNetworking'
    pod "CZPicker"
    pod "IQDropDownTextField"
 pod ‘JSQMessagesViewController’
 post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
             if config.name == 'Debug'
                 config.build_settings['ENABLE_TESTABILITY'] = 'YES'
                 config.build_settings['SWIFT_VERSION'] = '3.0'
             end
         end
     end
 end
 
end

