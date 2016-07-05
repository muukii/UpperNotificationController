Pod::Spec.new do |s|
  s.name             = "UpperNotificationController"
  s.version          = "0.6.4"
  s.summary          = "UpperNotificationController is core for appear notification to upper on app screen."
  s.homepage         = "https://github.com/muukii/UpperNotificationController"
  s.license          = 'MIT'
  s.author           = { "muukii" => "m@muukii.me" }
  s.source           = { :git => "https://github.com/muukii/UpperNotificationController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/muukii0803'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'UpperNotificationController/**/*.swift'

end
