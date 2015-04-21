require_relative "../../spec_helper"

describe "game-server-cookbook::logharvester" do
    let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe)
    end

    it 'installs git' do
        expect(chef_run).to install_package('git')
    end

    it 'syncs logharvester' do
        expect(chef_run).to sync_git("/git/viking-logharvester")
    end

    it 'sets up on-exit trigger' do
        expect(chef_run).to create_file("/git/viking-logharvester/harvest.sh")
        expect(chef_run).to create_link("/etc/rc0.d/S01Harvest")
    end
end