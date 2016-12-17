module DestoryComments
  extend ActiveSupport::Concern
  included do
    before_destroy :destroy_comments
  end

  def destroy_comments
    thread.destroy
  end
end