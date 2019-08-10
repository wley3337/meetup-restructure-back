class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :meet_up_oauth_token
      t.string :meet_up_refresh_token
      t.timestamps
    end
  end
end
