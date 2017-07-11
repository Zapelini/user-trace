class CreateContactTraces < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_traces do |t|
      t.string :url
      t.datetime :date_access
      t.references :contacts, foreign_key: true

      t.timestamps
    end
  end
end

