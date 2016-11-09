class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first
      t.string :last
      t.string :email
      t.string :password_digest
      t.string :office
      t.string :city
      t.string :state
      t.string :phone

      t.timestamps null: false
    end
  end
end
