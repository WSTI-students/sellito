class PostForm
  include ActiveModel::Model

  attr_reader :form_data
  attr_accessor :title, :expiration_date, :description, :category_id, :user_id

  validates :title, :description, :expiration_date, presence: true
  validate :expiration_date_cannot_be_in_the_past

  def initialize(form_data = nil)
    @form_data = form_data
    assign_current_values_on_edit if form_data
  end

  private

  def assign_current_values_on_edit
    @title = form_data[:title]
    @description = form_data[:description]
    @expiration_date = form_data[:expiration_date]
    @category_id = form_data[:category_id]
  end

  def expiration_date_cannot_be_in_the_past
    return unless expiration_date && expiration_date < Date.today.to_s
    errors.add(:expiration_date, 'cant be in the past!')
  end
end
