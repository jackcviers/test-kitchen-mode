require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe command('apt-get install numix-icon-theme numix-icon-theme-circle') do
  it 'should return exit status 0' do
    expect(return_exit_status).to equal 0
  end
end
