class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :limit => 25
      t.string :email, :limit => 100

      t.timestamps
    end
  end
end
