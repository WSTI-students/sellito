class AssignCategoryToPost

  attr_reader :category_id, :post

  def initialize(category_id:, post:)
    @category_id = category_id
    @post = post
  end

  def call
    category = Category.find(category_id.to_i)
    post.categories << category
  end
end
