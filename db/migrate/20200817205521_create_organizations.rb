class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :api_token, null:false, index: {unique: true}

      t.timestamps
    end

  end
end
