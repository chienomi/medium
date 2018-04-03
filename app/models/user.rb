class User < ActiveRecord::Base
	  has_many :funds, dependent: :destroy
	  has_many :favs, through: :funds, source: :demo
    has_many :evangelists
    has_many :conversations
    has_many :likes, dependent: :destroy
    has_many :liked_evangelists, through: :likes, source: :evangelist
    has_many :ucategorizations, dependent: :destroy
    has_many :categories, through: :ucategorizations
    has_many :bantags, dependent: :destroy
    has_many :hates, through: :bantags, source: :category
    has_many :onlineforms, dependent: :destroy
    has_many :playlists, dependent: :destroy
    has_many :identities, dependent: :destroy
    has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
    has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
    has_many :following, through: :active_relationships,  source: :followed
    has_many :followers, through: :passive_relationships, source: :follower



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :lockable,:omniauthable, :omniauth_providers => [:facebook, :twitter, :google, :stripe_connect]

    # for the uniqueness of users 2015/12/17
    validates :user_name, presence: true, uniqueness: true


  has_attached_file :image_user, styles:
  {
    medium: {geometry: "64x64>", format: 'png'},
    thumb: {geometry: "32x32>", format: 'png'},
  } ,
  preserve_files: false,
  :storage => :s3,
  :path => ":attachment/:id/:style/:filename",
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :url => ':s3_alias_url',
    :s3_alias_url => "i.....com",
    :s3_host_alias => 'i.....com',
    :s3_protocol => :https

    validates_attachment_content_type :image_user, content_type: /\Aimage\/.*\Z/,
        message: 'only jpeg, gif, png'
    validates_attachment_size :image_user, less_than: 1.megabyte,
        message: 'Check if the image is less than 1MB'

    has_attached_file :cover_u,
        styles: { medium: "640x125!"}
    validates_attachment_content_type :cover_u, content_type: /\Aimage\/.*\Z/,
        message: 'only jpeg, gif, png'
    validates_attachment_size :cover_u, less_than: 3.megabyte,
        message: 'Check if the image is less than 3MB'


 def self.find_for_oauth(auth, this_user)
    # Find an identity here
    @identity = Identity.find_with_omniauth(auth)
    # If no identity was found, create a brand new one here
    if @identity.nil?
        @identity = Identity.create_with_omniauth(auth)
    end

    if this_user != nil
        if @identity.user == this_user
          # Identity is already associated with this user
          # flash[:notice]="Already logged in and linked!"
          # redirect_to this_user, notice: "Already logged in and linked!"
        else
          # Identity is not associated with the current_user
          @identity.user = this_user
          @identity.save
          # flash[:notice]="Account was successfully linked!"
          # redirect_to @user, notice: "Account was successfully linked!"
        end
        user = this_user
    else
        if @identity.user.present?
           # Identity has a user associated with it
          # self.current_user = @identity.user
          user = @identity.user
          # flash[:notice]="Welcome back!"
          # redirect_to root_url, notice: "Signed in!"
        else
          # No user associated with the identity so we need to create a new one
          user = User.where(user_name: auth.info.name).first
          if user == nil
            user = User.create(
            # uid:      auth.uid,
            # provider: auth.provider,
            user_name: auth.info.name,
            email:    User.get_email(auth),
            password: Devise.friendly_token[6, 30],
            image_user: auth.info.image
            )
          else
            user = User.create(
            # uid:      auth.uid,
            # provider: auth.provider,
            user_name: auth.info.name + "_" + [*('a'..'z'),*('0'..'9')].shuffle[0,3].join,
            email:    User.get_email(auth),
            password: Devise.friendly_token[6, 30],
            image_user: auth.info.image
            )

          end
          @identity.user = user
          @identity.save
          # flash[:notice]="Welcome!"
          # self.current_user = @identity.user
          # redirect_to new_user_url, notice: "Registration successful"
        end
    end

    user
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  private
    def self.get_email(auth)
      email = auth.info.email
      email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
      email
    end

  #     extend FriendlyId
  # friendly_id :user_name
end
