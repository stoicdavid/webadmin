class TestController < ApplicationController
  
  def pdf
    report = Report.new
    pdf = Rupdf::Renderer.render_pdf do |o|
      o.report_title = 'This is a test of a var being passed.'
      o.smile_path = RAILS_ROOT + '/public/images/smile.jpg'
    end
    send_pdf(pdf)
  end
  
end
