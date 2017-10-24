Pod::Spec.new do |s|

  s.name         = "AdminSettingsControl"
  s.version      = "1.0.4"
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

end
