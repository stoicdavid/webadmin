# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090317041544) do

  create_table "agendas", :id => false, :force => true do |t|
    t.integer  "paciente_id", :null => false
    t.integer  "cita_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "citas", :force => true do |t|
    t.integer  "paciente_id",    :null => false
    t.integer  "operation_id",   :null => false
    t.datetime "fecha_hora"
    t.integer  "cubiculo"
    t.string   "persona_conf"
    t.boolean  "confirma_doc"
    t.boolean  "confirma_valet"
    t.string   "acompana"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consultas", :force => true do |t|
    t.integer  "paciente_id"
    t.integer  "doctor_id"
    t.integer  "cita_id"
    t.datetime "fecha_envio"
    t.datetime "fecha_consulta"
    t.text     "diagnostico"
    t.string   "fecha_in_sintomas"
    t.text     "medicina_anterior"
    t.text     "medicina_actual"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estudio_id"
  end

  create_table "doctors", :force => true do |t|
    t.string   "nombre"
    t.string   "nombre_2"
    t.string   "app_pat"
    t.string   "app_mat"
    t.string   "calle"
    t.string   "colonia"
    t.string   "estado"
    t.integer  "cp"
    t.string   "telefono_consultorio"
    t.string   "celular"
    t.string   "correo"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagen"
    t.integer  "especialidad_id"
    t.string   "especialidad_otro"
    t.string   "rfc_virtual"
    t.string   "rfc_doc"
    t.string   "razon_doc"
    t.string   "calle_fis"
    t.string   "num_ext_fis"
    t.string   "num_int_fis"
    t.string   "colonia_fis"
    t.string   "del_mun_fis"
    t.string   "estado_fis"
    t.string   "cp_fis"
    t.string   "genero"
  end

  create_table "especialidads", :force => true do |t|
    t.string   "especialidad"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "estudios" because of following StandardError
#   Unknown type 'precision8default0scale2' for column 'comision_doctor'

  create_table "generates", :id => false, :force => true do |t|
    t.integer  "operation_id"
    t.integer  "pago_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "generates", ["operation_id", "pago_id"], :name => "index_generates_on_operation_id_and_pago_id"

  create_table "horarios", :force => true do |t|
    t.string   "horas"
    t.integer  "cubiculo"
    t.integer  "cita_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "horas_ocupadas"
  end

  create_table "inters", :force => true do |t|
    t.text     "principal"
    t.text     "activaciones"
    t.text     "conclusion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "consulta_id"
  end

  create_table "operations", :force => true do |t|
    t.string   "ref_estudio"
    t.integer  "cita_id",              :null => false
    t.datetime "hora_llegada"
    t.datetime "ini_conexion"
    t.datetime "fin_conexion"
    t.datetime "ini_estudio"
    t.datetime "fin_estudio"
    t.date     "fecha_interpretacion"
    t.date     "fecha_entrega"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipo_id"
    t.integer  "pago_id"
    t.integer  "indice_estudio"
  end

  add_index "operations", ["cita_id"], :name => "index_operations_on_cita_id"

  create_table "pacientes", :force => true do |t|
    t.string   "nombre"
    t.string   "nombre_2"
    t.string   "app_pat"
    t.string   "app_mat"
    t.string   "rfc"
    t.string   "calle_fis"
    t.string   "colonia_fis"
    t.string   "estado_fis"
    t.integer  "cp_fis"
    t.string   "calle_dom"
    t.string   "colonia_dom"
    t.string   "estado_dom"
    t.integer  "cp_dom"
    t.string   "celular"
    t.string   "casa"
    t.string   "oficina"
    t.string   "recados"
    t.string   "fax"
    t.string   "correo"
    t.string   "pagina_web"
    t.date     "fecha_nac"
    t.string   "genero"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "razon"
    t.string   "del_mun"
    t.string   "del_mun_dom"
    t.string   "num_int_dom"
    t.string   "num_ext_dom"
    t.string   "num_int_fis"
    t.string   "num_ext_fis"
    t.string   "rfc_pac"
    t.string   "nombre_contacto"
    t.string   "parentezco"
    t.string   "correo_2"
  end

# Could not dump table "pagos" because of following StandardError
#   Unknown type 'precision8default0scale2' for column 'precio'

  create_table "referencias", :force => true do |t|
    t.string   "nombre"
    t.string   "apellidos"
    t.string   "nombre_contacto"
    t.string   "diagnostico"
    t.date     "fecha_referencia"
    t.string   "telefono_casa"
    t.string   "telefono_celular"
    t.string   "e_mail"
    t.integer  "ref_id",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "estudio_id"
    t.integer  "doctor_id"
    t.string   "ap_paterno"
    t.string   "ap_materno"
    t.date     "fecha_nac"
    t.string   "t_recados"
    t.string   "t_oficina"
    t.string   "t_fax"
    t.string   "email_2"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_usuarios", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "usuario_id"
  end

  add_index "roles_usuarios", ["role_id"], :name => "index_roles_usuarios_on_role_id"
  add_index "roles_usuarios", ["usuario_id"], :name => "index_roles_usuarios_on_usuario_id"

  create_table "searches", :force => true do |t|
    t.string   "nombre"
    t.string   "nombre_2"
    t.string   "ap_pat"
    t.string   "ap_mat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "specializations", :id => false, :force => true do |t|
    t.integer  "doctor_id",       :null => false
    t.integer  "especialidad_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "specializations", ["doctor_id", "especialidad_id"], :name => "index_specializations_on_doctor_id_and_especialidad_id"

  create_table "tipos", :id => false, :force => true do |t|
    t.integer  "estudio_id"
    t.integer  "operation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tipos", ["estudio_id", "operation_id"], :name => "index_tipos_on_estudio_id_and_operation_id"

  create_table "usuarios", :force => true do |t|
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_id"
    t.string   "login",                     :limit => 40
    t.string   "email",                     :limit => 100
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "imagen"
    t.string   "idioma"
  end

  add_index "usuarios", ["login"], :name => "index_usuarios_on_login", :unique => true

end
