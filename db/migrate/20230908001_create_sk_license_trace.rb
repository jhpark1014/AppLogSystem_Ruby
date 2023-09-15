class CreateSkLicenseTrace < ActiveRecord::Migration[7.0]
  def change
    create_table :sk_license_traces do |t|
      # t.decimal :id, precision: 8, scale: 0, null: false
      t.string :company, limit: 255, collation: 'ko_KR'
      t.string :server, limit: 255, collation: 'ko_KR'
      t.string :product, limit: 50, collation: 'ko_KR'
      t.string :total_sum, limit: 5, collation: 'ko_KR'
      t.string :use_sum, limit: 5, collation: 'ko_KR'
      t.datetime :create_date, default: -> { 'CURRENT_TIMESTAMP' }
    end
    add_index :sk_license_traces, :id, unique: true
  end
end
