class CreateUserCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :user_credentials, id: :uuid do |t|
      t.string :password_digest
      t.belongs_to :user, type: :uuid

      t.timestamps
    end
  end
end
