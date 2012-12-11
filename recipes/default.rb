if ['app_master', 'app', 'solo'].include?(node[:instance_role])
  # service
  service "nginx" do
    supports :reload => true
  end
  
  # stack.conf
  template "/etc/nginx/stack.conf" do
    source 'stack.conf.erb'
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    backup false
    variables({
      :user => node[:owner_name],
      :worker_count => node[:passenger_worker_count],
    })
    notifies :reload, resources(:service => :nginx), :delayed
  end
end