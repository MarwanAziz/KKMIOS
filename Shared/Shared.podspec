Pod::Spec.new do |spec|
    spec.name                     = 'Shared'
    spec.version                  = '1.0'
    spec.homepage                 = 'https://github.com/MarwanAziz/KKMIOS'
    spec.source       = { :git => 'https://github.com/MarwanAziz/KKMIOS.git', :tag => '1.0.0' }
    spec.authors                  = 'MarwanAziz'
    spec.license                  = 'MIT'
    spec.summary                  = 'Some description for a Kotlin/Native module'
    spec.vendored_frameworks      = 'build/cocoapods/framework/SharedLogic.framework'
    spec.libraries                = 'c++'
    spec.ios.deployment_target    = '16.0'
    spec.dependency 'shared', '1.0'
end