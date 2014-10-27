class V1::TracksController < V1::BaseController
  before_action :authorize

  def index
    @tracks = Track.all
  end

  private

  def authorize
    unless current_user
      head :unauthorized
    end
  end
end
