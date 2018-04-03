class Upload < ActiveRecord::Base
  belongs_to :evangelist


  has_attached_file :image, styles:
	{
  medium: {geometry: "700>", format: 'jpeg'},
  thumb: {geometry: "x320>", format: 'jpeg'}
  },
  # default_url: ->(attachment) { ActionController::Base.helpers.asset_path('universe.jpg') },
  preserve_files: false,
	:storage => :s3,
	:path => ":attachment/:id/:style/:filename",
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :url => ':s3_alias_url',
    :s3_alias_url => "i.....com",
    :s3_host_alias => 'i.....com',
    :s3_protocol => :https

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :image, less_than: 1.megabyte, message: 'You can upload an image which is less than 1MB'

end
