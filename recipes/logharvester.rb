#
# Cookbook Name:: game-server-cookbook
# Recipe:: logharvester
#
# Copyright (c) 2015 Shield Break Studios, All Rights Reserved.

package "git"

git "/git/viking-logharvester" do
    repository "https://github.com/Heuriskein/viking-logharvester.git"
    action :sync
end

file "/git/viking-logharvester/harvest.sh" do
    content "#!/bin/sh\n/usr/bin/python /git/viking-logharvester/harvester.py"
    action :create
    owner "root"
    group "root"
    mode "744"
end

link "/etc/rc0.d/S01Harvest" do
    to "/git/viking-logharvester/harvest.sh"
    action :create
end

