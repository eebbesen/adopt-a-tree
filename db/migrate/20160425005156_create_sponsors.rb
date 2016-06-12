class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string  :name
      t.string  :location
      t.string  :website
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
