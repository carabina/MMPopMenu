Pod::Spec.new do |s|
  s.name = 'MMPopMenu'
  s.version = '0.0.1'
  s.platform = :ios, '7.0'
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.summary = 'MMPopMenu is a vertical popup menu for using in iOS applications'
  s.homepage = 'https://github.com/xwgit2971/MMPopMenu'
  s.author = { 'SunnyX' => '1031787148@qq.com' }
  s.source = { :git => 'https://github.com/xwgit2971/MMPopMenu.git', :tag => s.version }
  s.source_files = 'MMPopMenu/*.{h,m}'
  s.framework = 'Foundation', 'UIKit'
  s.requires_arc = true
end
