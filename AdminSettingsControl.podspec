Pod::Spec.new do |s|

  s.name         = "AdminSettingsControl"
  s.version      = "1.0.5"
  s.summary      = "AdminSettingsControl for Admin Settings screen"
  s.description  = "AdminSettingsControl is used t9o display app & device specific Info i.e server URLs, App version, device ID etc."
  s.homepage     = "https://github.com/Kruks/AdminSettingsControl/blob/master/README.md"
  s.license      = "MIT"
  s.author             = "Krutika Gandhi"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Kruks/AdminSettingsControl.git", :tag => "#{s.version}" }
  s.source_files  = "AdminSettingsControl", "AdminSettingsControl/**/*.{h,m,swift,xib,png,strings}"
  s.requires_arc = true
  s.dependency 'SkyFloatingLabelTextField', '~> 3.0'
  s.dependency 'MBProgressHUD', '~> 0.9.2'
  s.dependency 'GoogleAPIClientForREST/Drive', '~> 1.2.1'
  s.dependency 'Google/SignIn', '~> 3.0.3'
  s.dependency 'YLProgressBar', '~> 3.8.1'
  s.static_framework = true
  s.pod_target_xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/Google',
    'OTHER_LDFLAGS' => '$(inherited) -undefined dynamic_lookup -ObjC'
  }
end
