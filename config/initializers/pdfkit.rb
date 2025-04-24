PDFKit.configure do |config|
  # Use the binary provided by the wkhtmltopdf-binary gem
  # This will automatically find the correct binary for the current platform
  # config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
  
  # Set global options
  config.default_options = {
    page_size: 'A4',
    margin_top: '10mm',
    margin_bottom: '10mm',
    margin_left: '10mm',
    margin_right: '10mm',
    encoding: 'UTF-8',
    print_media_type: true,
    disable_smart_shrinking: true,
    dpi: 300,
    image_quality: 100,
    enable_local_file_access: true,
    enable_plugins: true,
    load_error_handling: 'ignore'
  }
end
