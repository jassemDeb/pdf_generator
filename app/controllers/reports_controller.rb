class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy download_pdf preview_pdf ]

  # GET /reports or /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to report_url(@report), notice: "Report was successfully created." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to report_url(@report), notice: "Report was successfully updated." }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /reports/1/download_pdf
  def download_pdf
    respond_to do |format|
      format.html
      format.pdf do
        # Generate sample data for the report
        @report_data = generate_sample_data
        
        # Prepare logo for PDF
        @logo_path = Rails.root.join('app', 'assets', 'images', '1.png')
        @logo_data = nil
        if File.exist?(@logo_path)
          @logo_data = Base64.strict_encode64(File.read(@logo_path))
        end

        # Method 1: Using WickedPDF (original method)
        if params[:use_wicked].present?
          render pdf: "#{@report.title.parameterize}",
                template: 'reports/report_template',
                layout: 'pdf',
                page_size: 'A4',
                encoding: 'UTF-8',
                margin: { top: 10, bottom: 10, left: 10, right: 10 },
                footer: { center: '[page] of [topage]', font_size: 9 },
                disable_smart_shrinking: true,
                print_media_type: true,
                dpi: 300,
                image_quality: 100
        else
          # Method 2: Using PDFKit (alternative method)
          html = render_to_string(
            template: 'reports/report_template',
            layout: 'pdf',
            formats: [:pdf],
            handlers: [:erb]
          )
          
          # Create PDF from HTML with all options in one go
          kit = PDFKit.new(html, {
            page_size: 'A4',
            footer_center: 'Page [page] of [topage]',
            footer_font_size: 9,
            margin_top: '10mm',
            margin_bottom: '10mm',
            margin_left: '10mm',
            margin_right: '10mm',
            encoding: 'UTF-8',
            print_media_type: true,
            disable_smart_shrinking: true,
            dpi: 300,
            image_quality: 100,
            enable_local_file_access: true
          })
          
          # Send the PDF as a file download
          send_data kit.to_pdf, 
                    filename: "#{@report.title.parameterize}.pdf",
                    type: 'application/pdf',
                    disposition: 'attachment'
        end
      end
    end
  end

  # GET /reports/1/preview_pdf
  def preview_pdf
    # Generate sample data for the report
    @report_data = generate_sample_data
    
    # Prepare logo for PDF
    @logo_path = Rails.root.join('app', 'assets', 'images', '1.png')
    @logo_data = nil
    if File.exist?(@logo_path)
      @logo_data = Base64.strict_encode64(File.read(@logo_path))
    end

    # Method 1: Using WickedPDF (original method)
    if params[:use_wicked].present?
      pdf = render_to_string(
        pdf: "#{@report.title.parameterize}",
        template: 'reports/report_template',
        layout: 'pdf',
        page_size: 'A4',
        encoding: 'UTF-8',
        margin: { top: 10, bottom: 10, left: 10, right: 10 },
        footer: { center: '[page] of [topage]', font_size: 9 },
        disable_smart_shrinking: true,
        print_media_type: true,
        dpi: 300,
        image_quality: 100
      )
    else
      # Method 2: Using PDFKit (alternative method)
      html = render_to_string(
        template: 'reports/report_template',
        layout: 'pdf',
        formats: [:pdf],
        handlers: [:erb]
      )
      
      # Create PDF from HTML with all options in one go
      kit = PDFKit.new(html, {
        page_size: 'A4',
        footer_center: 'Page [page] of [topage]',
        footer_font_size: 9,
        margin_top: '10mm',
        margin_bottom: '10mm',
        margin_left: '10mm',
        margin_right: '10mm',
        encoding: 'UTF-8',
        print_media_type: true,
        disable_smart_shrinking: true,
        dpi: 300,
        image_quality: 100,
        enable_local_file_access: true
      })
      
      pdf = kit.to_pdf
    end
    
    # Send the PDF with inline disposition so it displays in the browser
    send_data pdf, 
              filename: "#{@report.title.parameterize}.pdf",
              type: 'application/pdf',
              disposition: 'inline'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:title, :content)
    end

    def generate_sample_data
      {
        title: @report.title,
        created_at: Time.now,
        updated_at: Time.now,
        executive_summary: {
          targets_scope: "example.com",
          summary: @report.content,
          overview: "This report provides a comprehensive security assessment of the target domain and identifies potential vulnerabilities and risks.",
          targets: "Primary target: example.com and all subdomains"
        },
        report_metadata: {
          report_version: "1.0",
          generated_by: "PDF Report Generator",
          generated_at: Time.now.strftime("%Y-%m-%d %H:%M:%S")
        },
        findings: {
          dns_records: [
            { type: "A", value: "192.168.1.1", ttl: 3600 },
            { type: "MX", value: "mail.example.com", ttl: 3600 },
            { type: "CNAME", value: "www.example.com", ttl: 3600 }
          ],
          whois_info: {
            registrar: "Example Registrar",
            created_date: "2020-01-01",
            expiry_date: "2025-01-01",
            updated_date: "2023-01-01"
          },
          network_info: {
            asn_count: 2,
            ip_addresses: ["192.168.1.1", "192.168.1.2"]
          },
          certificates: [
            {
              common_name: "*.example.com",
              issuer: "Let's Encrypt",
              valid_from: Time.now - 30.days,
              valid_to: Time.now + 60.days,
              status: "Valid"
            }
          ]
        },
        subdomains: ["api.example.com", "dev.example.com", "staging.example.com", "admin.example.com"],
        assets: ["Web Application", "API Gateway", "Database Server", "Load Balancer"],
        leaks: ["API Keys (GitHub)", "Customer Data (Pastebin)"]
      }
    end
end
