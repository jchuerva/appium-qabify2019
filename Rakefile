  
def run_tests(deviceName, deviceType, platformName, platformVersion, app)
  system("deviceName=\"#{deviceName}\" deviceType=#{deviceType} platformName=\"#{platformName}\" platformVersion=\"#{platformVersion}\" app=\"#{app}\" parallel_split_test spec/feature/login_spec.rb")
end

task :Andoid_Emulator_Phone_9 do
  run_tests('Android Emulator', 'Phone', 'Android', '5.1', './apk/qabify2019.apk')
end

task :Andoid_Emulator_Tablet_5_1 do
  run_tests('Android Emulator', 'Tablet', 'Android', '5.1', 'https://github.com/saucelabs-sample-test-frameworks/Java-Junit-Appium-Android/blob/master/resources/GuineaPigApp-debug.apk?raw=true')
end

task :Galaxy_S4_Emulator do
  run_tests('Samsung Galaxy S4 Emulator', '', 'Android', '4.4', 'https://github.com/saucelabs-sample-test-frameworks/Java-Junit-Appium-Android/blob/master/resources/GuineaPigApp-debug.apk?raw=true')
end

task :Galaxy_S5_Device do
  run_tests('Samsung Galaxy S5 Device', '', 'Android', '4.4', 'https://github.com/saucelabs-sample-test-frameworks/Java-Junit-Appium-Android/blob/master/resources/GuineaPigApp-debug.apk?raw=true')
end

multitask :test_sauce => [
    :Andoid_Emulator_Phone_5_1,
    :Galaxy_S4_Emulator,
    :Andoid_Emulator_Tablet_5_1,
    :Galaxy_S5_Device,

  ] do
    puts 'Running automation'
end