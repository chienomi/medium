class UploadsController < ApplicationController
  def upload_image
    @image = Upload.new(image: params[:files].first)
    @image.save
url_response = {
files:
[
  {
    url: @image.image.url(:medium)
  }
]
}
render :json => url_response
  end

  def destroy
asset = Upload.find(params[:id])
asset.destroy
end

  private
  def upload_params
      params.require(:upload).permit(:image,:evangelist,:evangelist_id,:evangelist_title)
    end

end
