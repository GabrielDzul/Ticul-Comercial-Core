class DocsController < ActionController::Base
  before_action { head :forbidden if Rails.env.production? }
  def app; end
end
