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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111201223259) do

  create_table "presentations", :force => true do |t|
    t.integer   "election_id"
    t.string    "title"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "presentations", ["election_id"], :name => "index_presentations_on_election_id"

  create_table "snapshots", :force => true do |t|
    t.integer  "presentation_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "election_id"
    t.integer  "at_i"
    t.integer  "deviation_from_median"
    t.integer  "deviation_from_mean"
    t.float    "percentage_of_max"
  end

  add_index "snapshots", ["election_id", "at_i"], :name => "index_snapshots_on_election_id_and_at_i"
  add_index "snapshots", ["presentation_id"], :name => "index_snapshots_on_presentation_id"

end
