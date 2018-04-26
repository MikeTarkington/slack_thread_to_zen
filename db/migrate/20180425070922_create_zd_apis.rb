class CreateZdApis < ActiveRecord::Migration[5.1]
  def change
    create_table :zd_apis do |t|

      t.timestamps
    end
  end
end
