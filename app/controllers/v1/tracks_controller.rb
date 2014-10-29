class V1::TracksController < V1::BaseController
  before_action :set_track, only: [:show, :update, :delete]
  before_action :authorize

  def index
    @tracks = Track.all
  end

  def show
  end

  def create
    @track = Track.create(track_params)
    respond_with @track
  end

  def update
    head :unauthorized
  end

  def destroy
    head :unauthorized
  end

  private

  def track_params
    params.require(:track).permit(:title, :artist)
  end

  def set_track
    @track = Track.find(params[:id])
  end

  def authorize
    unless current_user
      head :unauthorized
    end
  end
end
