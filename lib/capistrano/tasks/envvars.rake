namespace :envvars do
  desc 'Load environment variables'
  task :load do
    # Grab the current value of :default_env
    environment = fetch(:default_env, {})

    on roles(:app) do
      # Read in the environment file
      env_file = fetch(:env_file, "#{fetch(:deploy_to)}/shared/.env")
      lines = capture("cat #{env_file}")
      lines.each_line do |line|
        # Remove the "export " keyword, we have no use for that here
        line = line.strip.sub(/^export /, "")
        next if line.empty? || line.start_with?('#')
        # Clean up the input by removing line breaks, tabs etc
        line = line.gsub /[\t\r\n\f]+/, ""

        # Grab the key and value from the line
        key, value = line.split("=", 2)
        raise "Invalid environment entry for #{key.inspect}" unless key.match?(/\A[A-Za-z_][A-Za-z0-9_]*\z/) && value

        # Remove surrounding quotes if present
        value = value.slice(1..-2) if (value.start_with?('"') && value.end_with?('"')) || (value.start_with?("'") && value.end_with?("'"))

        # Store the value in our :default_env copy
        environment.store(key, value)
      end

      # Finally, update the global :default_env variable again
      set :default_env, environment
    end
  end
end
