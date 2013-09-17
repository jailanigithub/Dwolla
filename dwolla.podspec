Pod::Spec.new do |s|
  s.name         = "Dwolla"
  s.platform 	 = :ios, '5.0'
  s.summary      = "Dwolla integration needed files"
  s.homepage     = "https://github.com/jailanigithub/Dwolla"
  s.author       = { "Jailani" => "jailaninice@gmail.com" }
  s.source       = { :git => "https://github.com/jailanigithub/Dwolla.git"}
  s.source_files = 'Source'
  s.requires_arc = false
  s.frameworks = 'CoreGraphics', 'QuartzCore', 'GHUnitIOS', 'Foundation', 'SenTestingKit' 
end  
