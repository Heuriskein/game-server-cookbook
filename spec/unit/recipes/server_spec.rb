require_relative "../../spec_helper"

describe "game-server-cookbook::server" do
    let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe)
    end

    it 'includes relevant python recipes' do
        expect(chef_run).to include_recipe('python')
        expect(chef_run).to include_recipe('python::pip')
    end

    it 'installs boto' do
        expect(chef_run).to install_python_pip('boto')
    end

    it 'runs gameserver' do
        expect(chef_run).to once_runit_service('vikinggameserver1')
        expect(chef_run).to once_runit_service('vikinggameserver2')
        expect(chef_run).to once_runit_service('vikinggameserver3')
        expect(chef_run).to once_runit_service('vikinggameserver4')
    end
end