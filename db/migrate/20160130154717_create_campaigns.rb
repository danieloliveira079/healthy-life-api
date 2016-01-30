class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.boolean :active
      t.text :description
      t.string :interval
      t.string :category

      t.timestamps null: false
    end
  end
end
