class Sponsor < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_and_belongs_to_many :calls

  before_create :set_default_message, :unless => Proc.new { |s| s.default? }
  before_create :set_token, :set_auth_token

  validates :email, :presence => true, :email_format => true
  validates_numericality_of :amount, :greater_than => 4.99

  scope :successful, where(:successful => true)
  scope :minutes_remain, where('minutes_remaining > 0')

  def to_param
    self.token
  end

  def jsonify(current_sponsor)
    result = {}
    %w(message minutes_purchased minutes_remaining).each do |a|
      result[a.to_sym] = self.send(a)
    end
    result[:url] = "#{'http://' unless url.blank? || (url.present? && url.starts_with?('http://'))}#{self.url}"
    result[:image] = self.image? ? self.image.url.split('?')[0] : "http://pockethotline.com#{self.image}"
    result[:active] = current_sponsor == self ? true : false

    result
  end

  def set_minutes_purchased
  	min = (self.amount / 0.15).to_i
    self.update_attributes(:minutes_purchased => min, :minutes_remaining => min)
  end

  def set_default_message
    if name.present?
      text = "The generous #{name}."
    else
      text = "An anonymous supporter."
    end
    self.message = text
  end

  def self.current
    Sponsor.successful.minutes_remain.order(:created_at).first
  end

  after_initialize :init_attachment
  def init_attachment
    if Rails.configuration.x.s3.access_key_id.present? && Rails.configuration.x.s3.secret_access_key.present?
      self.class.has_attached_file :image,
        :styles => {
          :actual => "110x60#"
        },
        :storage => :s3,
        :s3_credentials => Rails.configuration.x.s3,
        :hash_secret => '3fc75b1586cec00063a7a32b51fde796137d19d793cc0d0c1db96c3a013aff816ae91cf51e8c86d02ad62ba57c4b4c75b6d13dc890aa5b4ec85bb9640a5d8361',
        :path => "/account/8/sponsors/:id/:hash_:style.:extension",
        :default_url => "/images/sponsor-default.png"
    end
  end

  private
  def set_token
    self.token = BCrypt::Engine.generate_salt.parameterize
    while Sponsor.find_by_token(self.token)
      self.token = BCrypt::Engine.generate_salt.parameterize
    end
  end

  def set_auth_token
    self.auth_token = BCrypt::Engine.generate_salt.parameterize
  end
end
