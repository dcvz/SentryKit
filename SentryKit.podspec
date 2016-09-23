Pod::Spec.new do |s|
  s.name             = 'SentryKit'
  s.version          = '0.1.1'
  s.summary          = 'Swift client for sentry.io'
  s.homepage         = 'https://github.com/dcvz/SentryKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'David Chavez' => 'david@dcvz.io' }
  s.source           = { :git => 'https://github.com/dcvz/SentryKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dcvz'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SentryKit/Sources/**/*.swift'
end
