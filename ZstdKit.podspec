Pod::Spec.new do |s|
  s.name         = 'ZstdKit'
  s.version      = '1.0.1'
  s.license      = { :type => 'BSD', :file => 'LICENSE' }
  s.summary      = 'A Swift and Objective-C category for Zstd (Zstandard) compression.'
  s.homepage     = 'https://github.com/luckymarmot/ZstdKit'
  s.authors      = { 'Paw' => 'https://paw.cloud' }
  s.source       = { :git => 'https://github.com/luckymarmot/ZstdKit.git', :tag => s.version, :submodules => true }

  s.ios.deployment_target  = '8.0'
  s.osx.deployment_target  = '10.8'
  s.requires_arc = true

  s.source_files = 'ZstdKit/*.{h,m,c}', 'Dependencies/zstd/lib/*.h', 'Dependencies/zstd/lib/common/*.{c,h}', 'Dependencies/zstd/lib/compress/*.{c,h}', 'Dependencies/zstd/lib/decompress/*.{c,h}'
  s.public_header_files = 'ZstdKit/*.h'

  s.pod_target_xcconfig = {
    'CLANG_WARN_COMMA' => false,
    'CLANG_WARN_UNREACHABLE_CODE' => false
  }
end
