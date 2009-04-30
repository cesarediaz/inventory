class AddTableModels < ActiveRecord::Migration
   def self.up
      create_table :models do |t|
        t.text  :description
        t.integer  :mark_id
      end
    end

    def self.down
      drop_table :models
    end

end
