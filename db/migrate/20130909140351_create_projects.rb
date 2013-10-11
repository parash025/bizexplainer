class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.decimal :video_duration
      t.string :voice_over
      t.string :video_type
      t.text :requirements
      t.string :project_status
      t.string :payment_status
      t.integer :user_id

      t.timestamps
    end
  end
end
