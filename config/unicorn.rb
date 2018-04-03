# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/var/www/haccast"

worker_processes 2
timeout 15
preload_app true  # 更新時ダウンタイム無し

# Unicorn socket
listen "/tmp/unicorn.sock"
# Unicorn PID file location
pid "/var/www/haccast/pids/unicorn.pid"

before_fork do |server, worker|
    old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
  
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

# Path to logs
stderr_path "/var/www/haccast/log/unicorn.log"
stdout_path "/var/www/haccast/log/unicorn.log"
