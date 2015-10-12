# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151012221817) do

  create_table "clientes", force: :cascade do |t|
    t.string   "nombreEmp"
    t.integer  "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "clientes", ["persona_id"], name: "index_clientes_on_persona_id"

  create_table "direccions", force: :cascade do |t|
    t.string   "tipo"
    t.string   "pais"
    t.string   "provincia"
    t.string   "ciudad"
    t.string   "direxac"
    t.integer  "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "direccions", ["persona_id"], name: "index_direccions_on_persona_id"

  create_table "fisicas", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido1"
    t.string   "apellido2"
    t.string   "sexo"
    t.string   "fechanac"
    t.integer  "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "fisicas", ["persona_id"], name: "index_fisicas_on_persona_id"

  create_table "hojas", force: :cascade do |t|
    t.string   "tiempoDef"
    t.string   "razondeser"
    t.integer  "portafolio_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "hojas", ["portafolio_id"], name: "index_hojas_on_portafolio_id"

  create_table "juridicas", force: :cascade do |t|
    t.string   "razonsocial"
    t.date     "fechacreac"
    t.integer  "persona_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "juridicas", ["persona_id"], name: "index_juridicas_on_persona_id"

  create_table "personas", force: :cascade do |t|
    t.string   "idpersona"
    t.string   "email"
    t.string   "tipopersona"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "portafolios", force: :cascade do |t|
    t.date     "fechaCreac"
    t.integer  "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "portafolios", ["cliente_id"], name: "index_portafolios_on_cliente_id"

  create_table "telefonos", force: :cascade do |t|
    t.string   "tipo"
    t.integer  "numero"
    t.integer  "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "telefonos", ["persona_id"], name: "index_telefonos_on_persona_id"

end
