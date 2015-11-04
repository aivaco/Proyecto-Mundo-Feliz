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

ActiveRecord::Schema.define(version: 20151104204217) do

  create_table "activos", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "entregable_id"
    t.integer  "recurso_id"
    t.boolean  "estado"
  end

  create_table "alianzas", force: :cascade do |t|
    t.string   "tipo"
    t.string   "nombreEmp"
    t.string   "proposito"
    t.date     "fechaFin"
    t.integer  "proyecto_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "alianzas", ["proyecto_id"], name: "index_alianzas_on_proyecto_id"

  create_table "bitacoras", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "entregable_id"
    t.integer  "recurso_id"
    t.string   "descripcion"
    t.date     "fecha"
  end

  create_table "certificacions", force: :cascade do |t|
    t.string   "descripcion"
    t.integer  "recurso_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "certificacions", ["recurso_id"], name: "index_certificacions_on_recurso_id"

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
    t.string   "dirExac"
    t.integer  "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "direccions", ["persona_id"], name: "index_direccions_on_persona_id"

  create_table "entregables", force: :cascade do |t|
    t.integer  "numero"
    t.date     "fechaEnt"
    t.string   "descripcion"
    t.integer  "proyecto_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "entregables", ["proyecto_id"], name: "index_entregables_on_proyecto_id"

  create_table "fisicas", force: :cascade do |t|
    t.string   "nombre"
    t.string   "apellido1"
    t.string   "apellido2"
    t.string   "sexo"
    t.date     "fechaNac"
    t.integer  "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "fisicas", ["persona_id"], name: "index_fisicas_on_persona_id"

  create_table "habilidads", force: :cascade do |t|
    t.string   "descripcion"
    t.integer  "recurso_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "habilidads", ["recurso_id"], name: "index_habilidads_on_recurso_id"

  create_table "hojas", force: :cascade do |t|
    t.string   "tiempoDef"
    t.string   "razonDeSer"
    t.integer  "portafolio_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "hojas", ["portafolio_id"], name: "index_hojas_on_portafolio_id"

  create_table "juridicas", force: :cascade do |t|
    t.string   "razonSocial"
    t.date     "fechaCreac"
    t.integer  "persona_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "juridicas", ["persona_id"], name: "index_juridicas_on_persona_id"

  create_table "materials", force: :cascade do |t|
    t.string   "tipo"
    t.string   "descripcion"
    t.string   "uso"
    t.date     "fechaFin"
    t.integer  "proyecto_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "materials", ["proyecto_id"], name: "index_materials_on_proyecto_id"

  create_table "personas", force: :cascade do |t|
    t.string   "idPersona"
    t.string   "email"
    t.string   "tipoPersona"
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

  create_table "proyectos", force: :cascade do |t|
    t.string   "nombre"
    t.float    "presupuesto"
    t.float    "precio"
    t.string   "estado"
    t.integer  "hoja_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "proyectos", ["hoja_id"], name: "index_proyectos_on_hoja_id"

  create_table "recursos", force: :cascade do |t|
    t.string   "almaMater"
    t.integer  "fisica_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "recursos", ["fisica_id"], name: "index_recursos_on_fisica_id"

  create_table "riesgos", force: :cascade do |t|
    t.string   "tipo"
    t.string   "descripcion"
    t.integer  "proyecto_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "riesgos", ["proyecto_id"], name: "index_riesgos_on_proyecto_id"

  create_table "rols", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "proyecto_id"
    t.integer  "recurso_id"
    t.string   "papel"
  end

  create_table "simple_captcha_data", force: :cascade do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key"

  create_table "telefonos", force: :cascade do |t|
    t.string   "tipo"
    t.integer  "numero"
    t.integer  "persona_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "telefonos", ["persona_id"], name: "index_telefonos_on_persona_id"

  create_table "users", force: :cascade do |t|
    t.string   "usuario"
    t.string   "remember_session"
    t.boolean  "estado"
    t.string   "IdTipo"
    t.string   "IdPersona"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "password"
    t.string   "provider"
    t.string   "uid"
    t.string   "remember_digest"
    t.integer  "persona_id"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
  end

  add_index "users", ["persona_id"], name: "index_users_on_persona_id"

end
