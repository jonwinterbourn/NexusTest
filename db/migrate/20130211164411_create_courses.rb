class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :id
      t.string :name
      t.text :summary

      t.timestamps
    end
  end
end
