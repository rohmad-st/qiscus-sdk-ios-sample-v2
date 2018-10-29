# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'qiscus-sdk-ios-sample-v2' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for qiscus-sdk-ios-sample-v2
  pod 'Qiscus', '~> 2.8.33'
  pod 'PKHUD', '~> 5.2'
  pod 'BadgeSwift', '~> 4.0'
  pod 'IQKeyboardManagerSwift'
  
  target 'qiscus-sdk-ios-sample-v2Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'qiscus-sdk-ios-sample-v2UITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'YES'
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
