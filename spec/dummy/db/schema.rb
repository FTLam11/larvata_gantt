# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_06_094129) do

  create_table "entities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "larvata_gantt_links", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.bigint "target_id", null: false
    t.integer "typing", default: 0, null: false
    t.integer "lag", default: 0, null: false
    t.index ["source_id"], name: "index_larvata_gantt_links_on_source_id"
    t.index ["target_id"], name: "index_larvata_gantt_links_on_target_id"
    t.index ["typing"], name: "index_larvata_gantt_links_on_typing"
  end

  create_table "larvata_gantt_portfolios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "entity_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_id"], name: "index_larvata_gantt_portfolios_on_entity_id"
  end

  create_table "larvata_gantt_tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "larvata_gantt_portfolio_id"
    t.bigint "user_id"
    t.integer "sort_order", default: 0, null: false
    t.string "parent"
    t.integer "typing", default: 0, null: false
    t.integer "priority", default: 1, null: false
    t.decimal "progress", precision: 3, scale: 2, default: "0.0", null: false
    t.datetime "end_date"
    t.datetime "start_date"
    t.string "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "details"
    t.index ["larvata_gantt_portfolio_id"], name: "index_larvata_gantt_tasks_on_larvata_gantt_portfolio_id"
    t.index ["user_id"], name: "index_larvata_gantt_tasks_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "larvata_gantt_links", "larvata_gantt_tasks", column: "source_id"
  add_foreign_key "larvata_gantt_links", "larvata_gantt_tasks", column: "target_id"
  add_foreign_key "larvata_gantt_portfolios", "entities"
  add_foreign_key "larvata_gantt_tasks", "larvata_gantt_portfolios"
  add_foreign_key "larvata_gantt_tasks", "users"
end
