
Pod::Spec.new do |s|
  s.name         = "digit-text-view"
  s.version      = "1.0.0"
  s.summary      = "验证码文本框"
  s.description  = <<-DESC
                    一个验证码输入框，用来填写验证码
                    DESC
  s.homepage     = "https://github.com/568071718/xh_textfield"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "lu" => "568071718@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/568071718/xh_textfield.git", :tag => s.version }
  s.source_files  = "v2/app/SourceCode/*.{h,m}"
  s.requires_arc = true
end
