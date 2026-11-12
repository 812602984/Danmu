Pod::Spec.new do |s|

  s.name         = "Danmu"
  s.version      = "0.0.1"
  s.summary      = "多行自动避让的 iOS 弹幕视图组件"
  s.description  = <<-DESC
                     轻量弹幕组件。支持多行显示、自动择行（挑最空的一行）、
                     追尾保护、视图复用，单条弹幕从右往左匀速飞过。
                   DESC

  s.homepage     = "https://github.com/812602984/Danmu"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "812602984" => "812602984@users.noreply.github.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/812602984/Danmu.git", :tag => "#{s.version}" }

  s.source_files = "Danmu/Controller/*.{h,m}"

  s.framework    = "UIKit"

  s.requires_arc = true

  s.dependency "Masonry"

end
