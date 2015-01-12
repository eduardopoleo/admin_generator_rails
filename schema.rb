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

ActiveRecord::Schema.define(version: 20150110152727) do

  create_table "admin", primary_key: "username", force: true do |t|
    t.string  "password", limit: 32, default: "", null: false
    t.integer "rating",              default: 0,  null: false
    t.integer "active",              default: 0,  null: false
  end

  create_table "cart_items", primary_key: "item_id", force: true do |t|
    t.string  "sid",           limit: 32, default: "0", null: false
    t.integer "product_id",               default: 0,   null: false
    t.float   "product_price", limit: 24, default: 0.0, null: false
    t.integer "quantity",                 default: 0,   null: false
  end

  create_table "categories", force: true do |t|
    t.integer "category_id",             default: 0,  null: false
    t.text    "cat_name",                             null: false
    t.integer "quicklink",               default: 0,  null: false
    t.string  "weblink",     limit: 100, default: "", null: false
    t.string  "cat_image",   limit: 50,  default: "", null: false
    t.integer "active",                  default: 0,  null: false
  end

  create_table "countries", force: true do |t|
    t.string "country", limit: 35, default: "", null: false
  end

  create_table "custom_pages", primary_key: "page_id", force: true do |t|
    t.string "page_name", limit: 35, default: "", null: false
    t.text   "page_text",                         null: false
  end

  create_table "customers", force: true do |t|
    t.string  "username",       limit: 50, default: "", null: false
    t.string  "password",       limit: 32, default: "", null: false
    t.string  "first_name",     limit: 25, default: "", null: false
    t.string  "last_name",      limit: 25, default: "", null: false
    t.string  "email",          limit: 50, default: "", null: false
    t.string  "company_name",   limit: 35, default: "", null: false
    t.string  "pstexempt",      limit: 20, default: "", null: false
    t.string  "bill_address",   limit: 50, default: "", null: false
    t.string  "bill_city",      limit: 25, default: "", null: false
    t.integer "bill_province",             default: 0,  null: false
    t.string  "bill_postal",    limit: 7,  default: "", null: false
    t.integer "bill_country",              default: 0,  null: false
    t.string  "bill_phone",     limit: 15, default: "", null: false
    t.string  "bill_extension", limit: 5,  default: "", null: false
    t.string  "bill_fax",       limit: 15, default: "", null: false
    t.string  "ship_address",   limit: 50, default: "", null: false
    t.string  "ship_city",      limit: 25, default: "", null: false
    t.integer "ship_province",             default: 0,  null: false
    t.string  "ship_postal",    limit: 7,  default: "", null: false
    t.integer "ship_country",              default: 0,  null: false
    t.string  "ship_phone",     limit: 15, default: "", null: false
    t.string  "ship_extension", limit: 5,  default: "", null: false
    t.string  "ship_fax",       limit: 15, default: "", null: false
    t.date    "join_date",                              null: false
    t.date    "last_visit",                             null: false
    t.integer "newsletter",                default: 1,  null: false
    t.integer "active",                    default: 0,  null: false
  end

  create_table "customers_pricing", primary_key: "pricing_id", force: true do |t|
    t.string  "username",    limit: 50,                          default: "",  null: false
    t.integer "product_id",                                      default: 0,   null: false
    t.decimal "price",                  precision: 10, scale: 2, default: 0.0, null: false
    t.integer "customer_id"
  end

  create_table "faq", primary_key: "faq_id", force: true do |t|
    t.text    "question",             null: false
    t.text    "answer",               null: false
    t.integer "active",   default: 0, null: false
  end

  create_table "links", primary_key: "link_id", force: true do |t|
    t.string  "company",     limit: 35,  default: "", null: false
    t.string  "website",     limit: 100, default: "", null: false
    t.text    "description",                          null: false
    t.string  "logo",        limit: 35,  default: "", null: false
    t.integer "active",                  default: 1,  null: false
  end

  create_table "order_items", primary_key: "item_id", force: true do |t|
    t.integer "order_id",                            default: 0,     null: false
    t.integer "product_id",                          default: 0,     null: false
    t.decimal "price",      precision: 10, scale: 2, default: 0.0,   null: false
    t.integer "quantity",                            default: 0,     null: false
    t.boolean "chargepst",                           default: false, null: false
  end

  create_table "orders", primary_key: "order_id", force: true do |t|
    t.string  "username",       limit: 50,                          default: "",   null: false
    t.decimal "subtotal",                  precision: 10, scale: 2, default: 0.0,  null: false
    t.decimal "pst",                       precision: 10, scale: 2, default: 0.0,  null: false
    t.decimal "gst",                       precision: 10, scale: 2, default: 0.0,  null: false
    t.decimal "shipping",                  precision: 10, scale: 2, default: 0.0,  null: false
    t.decimal "total",                     precision: 10, scale: 2, default: 0.0,  null: false
    t.date    "purchase_date",                                                     null: false
    t.date    "processed_date",                                                    null: false
    t.date    "approved_date",                                                     null: false
    t.date    "shipped_date",                                                      null: false
    t.string  "ponumber",       limit: 30,                          default: "",   null: false
    t.text    "instructions",                                                      null: false
    t.text    "requests",                                                          null: false
    t.string  "archived",       limit: 2,                           default: "PE", null: false
    t.integer "customer_id"
  end

  create_table "products", primary_key: "product_id", force: true do |t|
    t.integer "cat_id",                                                          default: 0,   null: false
    t.text    "product_name",                                                                  null: false
    t.string  "product_code",        limit: 11,                                  default: "0", null: false
    t.text    "product_description", limit: 2147483647,                                        null: false
    t.decimal "product_price",                          precision: 10, scale: 2, default: 0.0, null: false
    t.string  "product_image",       limit: 50,                                  default: "",  null: false
    t.string  "product_uom",         limit: 15,                                  default: "",  null: false
    t.text    "extra_images",                                                                  null: false
    t.string  "active",              limit: 1,                                   default: "1", null: false
  end

  create_table "provinces", primary_key: "province_id", force: true do |t|
    t.string  "short_name",   limit: 2,  default: "",   null: false
    t.string  "long_name",    limit: 25, default: "",   null: false
    t.integer "country_code",            default: 1,    null: false
    t.float   "gst",          limit: 24, default: 0.06, null: false
    t.float   "pst",          limit: 24, default: 0.0,  null: false
  end

  create_table "request_quote", primary_key: "request_id", force: true do |t|
    t.string    "randkey",       limit: 7,  default: "", null: false
    t.string    "firstname",     limit: 25, default: "", null: false
    t.string    "lastname",      limit: 25, default: "", null: false
    t.string    "title",         limit: 25, default: "", null: false
    t.string    "company_name",  limit: 35, default: "", null: false
    t.string    "address1",      limit: 35, default: "", null: false
    t.string    "address2",      limit: 35, default: "", null: false
    t.string    "city",          limit: 30, default: "", null: false
    t.string    "province",      limit: 3,  default: "", null: false
    t.string    "postal",        limit: 7,  default: "", null: false
    t.integer   "countries",                default: 0,  null: false
    t.string    "phone",         limit: 15, default: "", null: false
    t.string    "fax",           limit: 15, default: "", null: false
    t.string    "email",         limit: 50, default: "", null: false
    t.string    "website",       limit: 50, default: "", null: false
    t.string    "partnumbers",   limit: 50, default: "", null: false
    t.text      "descriptions",                          null: false
    t.string    "quantity",      limit: 25, default: "", null: false
    t.string    "targetprice",   limit: 25, default: "", null: false
    t.string    "required_date", limit: 5,  default: "", null: false
    t.string    "annual_usage",  limit: 25, default: "", null: false
    t.text      "comments",                              null: false
    t.timestamp "created_at",                            null: false
  end

  create_table "settings", primary_key: "settings_id", force: true do |t|
    t.string  "name",     limit: 50, default: "",    null: false
    t.string  "variable", limit: 50, default: "",    null: false
    t.text    "value",                               null: false
    t.boolean "textbox",             default: false, null: false
  end

  create_table "specials", primary_key: "special_id", force: true do |t|
    t.integer "section",                 default: 0,         null: false
    t.string  "special_type", limit: 8,  default: "product", null: false
    t.string  "type_id",      limit: 7,  default: "",        null: false
    t.string  "title",        limit: 35, default: "",        null: false
    t.text    "description",                                 null: false
    t.date    "start_date",                                  null: false
    t.date    "end_date",                                    null: false
    t.integer "order",                   default: 0,         null: false
    t.string  "active",       limit: 5,  default: "true",    null: false
  end

end
