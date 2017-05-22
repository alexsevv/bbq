class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, required: false

  validates :event, presence: true

  #для незарегистрированных юзеров
  validates :user_name, presence: true, unless: 'user.present?'
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: 'user.present?'

  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'
  validates :user_email, uniqueness: {scope: :event_id}, unless: 'user.present?'
  validate :user_email, :existed_email, unless: 'user.present?'

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def existed_email
    errors.add(:user_email, I18n.t('activerecord.errors.messages.existed_email')) if User.where(email: user_email).exists?
  end
end
