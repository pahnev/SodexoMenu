Pod::Spec.new do |s|
  s.name         = 'SodexoMenuApp'
  s.version      = '1.01'
  s.license      =  :type => '<#License#>'
  s.homepage     = '<#Homepage URL#>'
  s.authors      =  '<#Author Name#>' => '<#Author Email#>'
  s.summary      = '<#Summary (Up to 140 characters#>'

# Source Info
  s.platform     =  :ios, '<#iOS Platform#>'
  s.source       =  :git => '<#Github Repo URL#>', :tag => '<#Tag name#>'
  s.source_files = '<#Resources#>'
  s.framework    =  '<#Required Frameworks#>'

  s.requires_arc = true
  
# Pod Dependencies
  s.dependencies =	pod "AFNetworking"
  s.dependencies =	pod 'MMDrawerController/MMDrawerVisualStates', '~> 0.5.7'

end