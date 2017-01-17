class CreateCreds < ActiveRecord::Migration
  def change
    create_table :creds do |t|
      t.references :user, index: true
      t.string :patterson_u
      t.string :patterson_p
      t.string :safco_u
      t.string :safco_p
      t.string :darby_u
      t.string :darby_p
      t.string :henry_u
      t.string :henry_p
      t.string :benco_u
      t.string :benco_p

      t.timestamps null: false
    end
    add_foreign_key :creds, :users
  end
end
