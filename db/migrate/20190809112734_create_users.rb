class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :map_box_oauth_token
      t.timestamps
    end
  end
end
