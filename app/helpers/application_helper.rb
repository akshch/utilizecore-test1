module ApplicationHelper

  def get_url(report)
    Rails.application.routes.url_helpers.rails_blob_path(report.document, only_path: true)
  end
end
