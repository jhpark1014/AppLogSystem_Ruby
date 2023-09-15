class CreatePdmLogData < ActiveRecord::Migration[7.0]
  def change
    create_table :pdm_log_data do |t|

      t.timestamps
    end
  end
end
