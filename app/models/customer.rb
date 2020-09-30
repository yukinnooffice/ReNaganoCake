class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy


  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :tel, presence: true, format: {with: /\A\d{10,11}\z/}, numericality: true
  validates :zipcode, presence: true, format: {with: /\A\d{7}\z/}, numericality: true
  validates :address, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true


   def active_for_authentication?
    super && (self.customer_status == true)
  end

  def self.search(search, model)
    if model == "customer"
      Customer.where('first_name_kana LIKE ? OR last_name_kana LIKE ? OR first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Customer.all
    end
  end

end
