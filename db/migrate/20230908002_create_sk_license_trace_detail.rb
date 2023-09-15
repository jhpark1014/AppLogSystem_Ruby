class CreateSkLicenseTraceDetail < ActiveRecord::Migration[7.0]
  def change
    create_table :sk_license_trace_details, id: false do |t|
      t.integer :id, precision: 8, scale: 0, null: false
      t.string :user_name, limit: 50, collation: 'ko_KR'
      t.string :desktop, limit: 50, collation: 'ko_KR'
      t.string :display, limit: 50, collation: 'ko_KR'
      t.string :version, limit: 50, collation: 'ko_KR'
      t.string :start_date, limit: 50, collation: 'ko_KR'
      t.datetime :create_date, default: -> { 'CURRENT_TIMESTAMP' }
    end
    add_foreign_key :sk_license_trace_details, :sk_license_traces, column: :id, primary_key: :id
  end
end
