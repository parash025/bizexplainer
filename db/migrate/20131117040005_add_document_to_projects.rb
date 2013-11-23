class AddDocumentToProjects < ActiveRecord::Migration
    def change
      add_attachment :projects, :document
    end
end
