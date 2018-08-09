class Product < ActiveRecord::Base
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :category, optional: true

  before_save :strip_html_from_description
  def strip_html_from_description
     self.description = ActionView::Base.full_sanitizer.sanitize(description)
  end

  before_save :lower_title
  def lower_title
     self.title = title.downcase
  end

  validate :title_is_shorter_than_description
  def title_is_shorter_than_description
      return if title.blank? or description.blank?
      if description.length < title.length
         errors.add(:description, 'can\'t be shorter than title')
      end
  end
end
