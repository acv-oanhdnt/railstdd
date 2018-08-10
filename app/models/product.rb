class Product < ActiveRecord::Base
  belongs_to :category, optional: true

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validate :title_is_shorter_than_description

  before_save :strip_html_from_description
  before_save :lower_title

  def strip_html_from_description
     self.description = ActionView::Base.full_sanitizer.sanitize(description)
  end

  def lower_title
     self.title = title.downcase
  end

  def title_is_shorter_than_description
    if title.present? && description.present? && title.length > description.length
      errors.add(:title, 'Title must be shorter than description')
  end
end
