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
    spec.ios.deployment_target = '16.0'
    spec.dependency 'shared', '1.0'
                
    if !Dir.exist?('build/cocoapods/framework/SharedLogic.framework') || Dir.empty?('build/cocoapods/framework/SharedLogic.framework')
        raise "

        Kotlin framework 'SharedLogic' doesn't exist yet, so a proper Xcode project can't be generated.
        'pod install' should be executed after running ':generateDummyFramework' Gradle task:

            ./gradlew :Shared:generateDummyFramework

        Alternatively, proper pod installation is performed during Gradle sync in the IDE (if Podfile location is set)"
    end
                
    spec.pod_target_xcconfig = {
        'KOTLIN_PROJECT_PATH' => ':Shared',
        'PRODUCT_MODULE_NAME' => 'SharedLogic',
    }
                
    spec.script_phases = [
        {
            :name => 'Build Shared',
            :execution_position => :before_compile,
            :shell_path => '/bin/sh',
            :script => <<-SCRIPT
                if [ "YES" = "$OVERRIDE_KOTLIN_BUILD_IDE_SUPPORTED" ]; then
                  echo "Skipping Gradle build task invocation due to OVERRIDE_KOTLIN_BUILD_IDE_SUPPORTED environment variable set to \"YES\""
                  exit 0
                fi
                set -ev
                REPO_ROOT="$PODS_TARGET_SRCROOT"
                "$REPO_ROOT/../gradlew" -p "$REPO_ROOT" $KOTLIN_PROJECT_PATH:syncFramework \
                    -Pkotlin.native.cocoapods.platform=$PLATFORM_NAME \
                    -Pkotlin.native.cocoapods.archs="$ARCHS" \
                    -Pkotlin.native.cocoapods.configuration="$CONFIGURATION"
            SCRIPT
        }
    ]
                
end