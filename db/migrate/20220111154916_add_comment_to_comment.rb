class AddCommentToComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :comment, foreign_key: true
  end
end
