# WickedPDF Global Configuration
WickedPdf.config = {
  # Use the binary provided by the wkhtmltopdf-binary gem
  # This will automatically find the correct binary for the current platform
  # exe_path: '/usr/local/bin/wkhtmltopdf',
  layout: 'pdf.html.erb',
  margin: {
    top: 10,
    bottom: 10,
    left: 10,
    right: 10
  },
  page_size: 'A4',
  encoding: 'UTF-8',
  print_media_type: true,
  disable_smart_shrinking: true,
  dpi: 300,
  image_quality: 100,
  # Add asset host for proper asset path resolution
  asset_host: "file:///#{Rails.root.join('public')}"
}
