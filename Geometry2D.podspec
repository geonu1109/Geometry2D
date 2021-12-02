Pod::Spec.new do |spec|
  spec.name                     = 'Geometry2D'
  spec.version                  = '1.0.2'
  spec.license                  = { :type => 'MIT', :file => 'LICENSE.txt' }
  spec.homepage                 = 'https://github.com/geonu1109/Geometry2D'
  spec.authors                  = { 'Geonu Jeon' => 'geonu1109@gmail.com' }
  spec.summary                  = 'Geometry2D is a Swift library implementing geometric functions.'
  spec.source                   = { :git => 'https://github.com/geonu1109/Geometry2D.git', :tag => spec.version.to_s }
  spec.swift_version            = '5.0'
  spec.ios.deployment_target    = '11.0'
  spec.source_files             = 'Sources/**/*.swift'
  spec.framework                = 'Foundation'
  spec.dependency 'Angle', '1.2.2'
end
