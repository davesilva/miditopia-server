class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :midi_file
      t.references :track, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
