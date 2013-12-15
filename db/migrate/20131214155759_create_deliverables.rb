class CreateDeliverables < ActiveRecord::Migration
  def change
    create_table :deliverables do |t|
      t.references :project, index: true

      t.timestamps
    end
  end
end
