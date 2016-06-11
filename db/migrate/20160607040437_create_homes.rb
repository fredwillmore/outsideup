class CreateHomes < ActiveRecord::Migration
  def up
    create_table :homes do |t|
      t.boolean :singleton_guard
      t.text :content
      t.text :phone
      t.timestamps
    end
    add_index(:homes, :singleton_guard, unique: true)

    Home.create(
      singleton_guard: 0,
      content: ":company_name  is located in Portland, OR.
All our structures are Custom-built, On-site, to fit your style and your needs. For free estimates and information, please send us a message. You can also contact owner Mike Olfert at: :phone.<br>",
      phone: "503.481.4484"
    )
  end

  def down
    drop_table :homes
  end
end
