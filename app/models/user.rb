class User < ApplicationRecord
    before_save { self.email.downcase! } #文字を全て小文字に変換
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    has_secure_password #ログイン認証のための準備を用意
    
    has_many :tasks
end