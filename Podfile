# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RealmSyncDemo' do
  use_frameworks!
  pod 'RealmSwift', '~> 2.3'

  target 'RealmSyncDemoTests' do
    inherit! :search_paths
  end

  target 'RealmSyncDemoUITests' do
    inherit! :search_paths
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
