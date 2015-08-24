class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :first_name
        t.string :mobile_number
        t.string :college
        t.string :email_id
        t.string :password
      t.timestamps null: false
    end
  end
end
