# 📄 PDF Report Generator

![Logo](app/assets/images/1.png)

A professional Rails application for generating well-formatted, branded PDF reports from HTML content. This application provides a user-friendly interface for creating, managing, and downloading PDF reports with consistent styling and branding.

## ✨ Features

- **🔄 Dual PDF Generation Engines**: Supports both WickedPDF and PDFKit for flexible PDF generation
- **🖼️ Base64 Image Embedding**: Ensures logos and images display correctly in generated PDFs
- **📝 Customizable Templates**: Clean, responsive HTML templates for professional report generation
- **👁️ Preview Functionality**: In-browser PDF preview before downloading
- **🎨 Consistent Branding**: Maintains brand colors and styling across all reports
- **📱 Responsive Design**: Mobile-friendly interface for managing reports

## 🛠️ Technology Stack

- **💎 Ruby**: 3.2.3
- **🚆 Rails**: 7.1.3
- **🗄️ Database**: SQLite (development), PostgreSQL (production-ready)
- **📊 PDF Generation**: WickedPDF and PDFKit with wkhtmltopdf
- **🎭 Frontend**: Bootstrap 5 for responsive UI
- **📦 Asset Management**: Importmaps for JavaScript management

## 🚀 Installation

### 📋 Prerequisites

- Ruby 3.2.3 or higher
- Node.js and Yarn
- wkhtmltopdf binary (installed automatically via gems)

### 🔧 Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/jassemDeb/pdf_generator.git
   cd pdf_report_generator
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed  # Optional: loads sample data
   ```

4. Start the Rails server:
   ```bash
   bin/dev
   ```

5. Visit `http://localhost:3000` in your browser

## 📑 PDF Generation Methods

### 📘 WickedPDF

The application uses WickedPDF as one of its PDF generation engines. WickedPDF is a Ruby wrapper for wkhtmltopdf, which uses WebKit to convert HTML to PDF.

```ruby
# Example WickedPDF usage in the application
render pdf: "report_name",
       template: 'reports/report_template',
       layout: 'pdf',
       page_size: 'A4',
       encoding: 'UTF-8'
```

### 📙 PDFKit

As an alternative to WickedPDF, the application also supports PDFKit, another Ruby wrapper for wkhtmltopdf.

```ruby
# Example PDFKit usage in the application
html = render_to_string(template: 'reports/report_template', layout: 'pdf')
kit = PDFKit.new(html, page_size: 'A4', encoding: 'UTF-8')
pdf = kit.to_pdf
```

## 🧩 Key Components

### 🎮 Controllers

- **ReportsController**: Manages report CRUD operations and PDF generation
  - `download_pdf`: Generates downloadable PDFs
  - `preview_pdf`: Renders PDFs inline for preview

### 👀 Views

- **report_template.pdf.erb**: The main template for PDF generation
- **layouts/pdf.html.erb**: PDF-specific layout with custom styling
- **reports/show.html.erb**: Includes PDF preview functionality

### ⚙️ Configuration

- **config/initializers/wicked_pdf.rb**: WickedPDF configuration
- **config/initializers/pdfkit.rb**: PDFKit configuration

## 🎨 Customization

### 🖼️ Changing the Logo

To change the logo used in the PDF reports:

1. Replace the image file at `app/assets/images/1.png` with your own logo
2. The application automatically encodes the logo as base64 for embedding in PDFs

### 📝 Modifying Report Templates

Edit the following files to customize the report templates:

- `app/views/reports/report_template.pdf.erb`: Main PDF content template
- `app/views/layouts/pdf.html.erb`: PDF layout and styling

### 🎭 Changing Colors and Branding

The application uses the following brand colors that can be modified:

- Primary (Royal Blue): `#2a4caa`
- Secondary (Light Blue): `#00adee`
- Accent (Dark Gray): `#5a5a5a`

## 🚢 Deployment

The application is ready for deployment to any Rails-compatible hosting platform:

1. Update `config/database.yml` for production database settings
2. Set appropriate environment variables for production
3. Deploy using your preferred method (Capistrano, Heroku, etc.)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgements

- [WickedPDF](https://github.com/mileszs/wicked_pdf) - HTML to PDF converter
- [PDFKit](https://github.com/pdfkit/pdfkit) - HTML to PDF generation
- [wkhtmltopdf](https://wkhtmltopdf.org/) - Open source command line tools to render HTML into PDF
- [Bootstrap](https://getbootstrap.com/) - Front-end framework
- [Rails](https://rubyonrails.org/) - Web application framework
- [Font Awesome](https://fontawesome.com/) - Icon library

---

Developed with ❤️ by [Jassem](https://github.com/jassemDeb)