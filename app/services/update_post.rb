class UpdatePost
  attr_reader :form_data, :post

  def initialize(form_data:, post:)
    @form_data = form_data
    @post = post
  end

  def call
    update_post_attributes
    assign_post_categories
  end

  private

  def update_post_attributes
    post.update_attributes(
      title: form_data.title,
      description: form_data.description,
      expiration_date: form_data.expiration_date
    )
  end

  def assign_post_categories
    category = Category.find(form_data.category_id)
    post.categories << category
  end
end
