class AddReplyToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :reply, :boolean
  end
end
