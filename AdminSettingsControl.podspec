Pod::Spec.new do |s|

  s.name         = "AdminSettingsControl"
  s.version      = "1.0.13"
  s.summary      = "AdminSettingsControl for Admin Settings screen"
  s.description  = "AdminSettingsControl is used to display app & device specific Info i.e server URLs, App version, device ID etc."
  s.homepage     = "https://github.com/Kruks/AdminSettingsControl/blob/master/README.md"
  s.license      = "MIT"
  s.author             = "Krutika Gandhi"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Kruks/AdminSettingsControl.git", :tag => "#{s.version}" }
  s.source_files  = "AdminSettingsControl", "AdminSettingsControl/**/*.{h,m,swift,xib,png}"
  s.requires_arc = true
  s.dependency 'SkyFloatingLabelTextField', '~> 3.0'
  s.dependency 'MBProgressHUD', '~> 0.9.2'
  s.dependency 'GoogleAPIClientForREST/Drive', '~> 1.2.1'
  s.dependency 'GoogleSignIn', '~> 4.0'
  s.dependency 'YLProgressBar', '~> 3.8.1'
  s.pod_target_xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/GoogleSignIn/Frameworks/',
    'LIBRARY_SEARCH_PATHS' => "$(inherited) $(PODS_ROOT)/GoogleSignIn/Frameworks/",
  }
  s.xcconfig = {'LIBRARY_SEARCH_PATHS' => "$(SRCROOT)/Pods/GoogleSignIn/"}
end
