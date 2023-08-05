Rails.application.config.to_prepare do
  # Initialize subscriber classes
  Dir.glob(File.join(Rails.root, 'app', 'subscribers', '*_subscriber.rb')).sort.each do |file_path|
    class_name = File.basename(file_path, '.rb').camelize
    class_name.constantize
  end
end