class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      #the index on the references line tells the databse to index the post_id column
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
