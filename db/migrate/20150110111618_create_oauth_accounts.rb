class CreateOauthAccounts < ActiveRecord::Migration
  def change
    create_table :oauth_accounts do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :location
      t.string :token
    end

    add_foreign_key :oauth_accounts, :users
  end
end
