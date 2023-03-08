class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.integer :temperature
      t.string :forecast
      t.references(:address, index: true)

      t.timestamps
    end
  end
end
