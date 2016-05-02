class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  # Pour validé un post, l'utilisateur doit :
  # Renseigné sont titre avec minimum 5 caractéres
  # Renseigné son corp
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end
