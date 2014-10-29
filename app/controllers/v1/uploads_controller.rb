class V1::UploadsController < V1::BaseController
  before_action :set_upload, only: [:show, :destroy]
  before_action :authorize

  def index
    @uploads = Upload.all
  end

  def show
  end

  def create
    @upload = Upload.new(upload_params)
    @upload.user = current_user
    @upload.save

    respond_with @upload
  end

  def destroy
    if @upload.user_id == current_user.id
      @upload.destroy
      head :ok
    else
      head :unauthorized
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:midi_file)
  end

  def set_upload
    @upload = Upload.find(params[:id])
  end

  def authorize
    unless current_user
      head :unauthorized
    end
  end
end
