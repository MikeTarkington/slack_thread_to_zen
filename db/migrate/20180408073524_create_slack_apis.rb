class CreateSlackApis < ActiveRecord::Migration[5.1]
  def change
    create_table :slack_apis do |t|

      t.timestamps
    end
  end
end
