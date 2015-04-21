#
# Cookbook Name:: game-server-cookbook
# Recipe:: server
#

# TODO: Move logic to library
require "ipaddress"

include_recipe "python"
include_recipe "python::pip"
include_recipe "runit"

python_pip "boto" do
    action :install
end

server_count = node['game-server-cookbook']['server]['server_count']
for in in 1..server_count do
    d = "/etc/sv/vikinggameserver#{i}"
    directory d
        action :create
        owner "root"
        group "root"
    end

    if not IPAddress.valid? node['game-server-cookbook']['server]['docker-ip'] then
        fail "Invalid Docker IP Address"
    end

    runit_service "
    file "#{d}/run" do
        template "server/server_run.erb"

        variables(
            'branch_name' =>  node['game-server-cookbook']['server]['branch'],
            'port1' => 7777 + (i * 2),
            'port2' => 7778 + (i * 2),
            'port3' => 27015 + i,
            'dockerIP' => node['game-server-cookbook']['server]['docker-ip']
        )
    end

end