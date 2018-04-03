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

ActiveRecord::Schema.define(version: 20160816231606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bantags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "bantags", ["category_id"], name: "index_bantags_on_category_id", using: :btree
  add_index "bantags", ["user_id"], name: "index_bantags_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "lock",       default: 0
    t.integer  "i_likes",    default: 0
    t.float    "rating",     default: 0.0
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "categorizations", force: :cascade do |t|
    t.integer  "evangelist_id"
    t.integer  "category_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree
  add_index "categorizations", ["evangelist_id"], name: "index_categorizations_on_evangelist_id", using: :btree

  create_table "charges", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "time"
    t.integer  "user_id"
    t.string   "user_name"
    t.text     "body"
    t.integer  "demo_id"
    t.integer  "vote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["demo_id"], name: "index_comments_on_demo_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "conversation_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "conversation_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "conversation_anc_desc_udx", unique: true, using: :btree
  add_index "conversation_hierarchies", ["descendant_id"], name: "conversation_desc_idx", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "time"
    t.integer  "user_id"
    t.string   "user_name"
    t.text     "body"
    t.integer  "evangelist_id"
    t.integer  "vote"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "title"
    t.text     "paragraph"
    t.integer  "showside_num"
    t.integer  "like",          default: 0
    t.integer  "parent_id"
    t.text     "a_str"
  end

  add_index "conversations", ["evangelist_id"], name: "index_conversations_on_evangelist_id", using: :btree
  add_index "conversations", ["user_id"], name: "index_conversations_on_user_id", using: :btree

  create_table "demos", force: :cascade do |t|
    t.string   "title"
    t.text     "post_short"
    t.text     "post"
    t.integer  "user_id"
    t.string   "user_name"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "demo_img_file_name"
    t.string   "demo_img_content_type"
    t.integer  "demo_img_file_size"
    t.datetime "demo_img_updated_at"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "file_exe_file_name"
    t.string   "file_exe_content_type"
    t.integer  "file_exe_file_size"
    t.datetime "file_exe_updated_at"
    t.string   "video_s_file_name"
    t.string   "video_s_content_type"
    t.integer  "video_s_file_size"
    t.datetime "video_s_updated_at"
    t.text     "story"
    t.text     "os"
    t.text     "audio"
    t.text     "subtitle"
    t.text     "res_m"
    t.text     "mem_m"
    t.text     "res_r"
    t.text     "mem_r"
    t.string   "image_c1_file_name"
    t.string   "image_c1_content_type"
    t.integer  "image_c1_file_size"
    t.datetime "image_c1_updated_at"
    t.string   "image_c2_file_name"
    t.string   "image_c2_content_type"
    t.integer  "image_c2_file_size"
    t.datetime "image_c2_updated_at"
    t.string   "image_c3_file_name"
    t.string   "image_c3_content_type"
    t.integer  "image_c3_file_size"
    t.datetime "image_c3_updated_at"
    t.string   "image_c4_file_name"
    t.string   "image_c4_content_type"
    t.integer  "image_c4_file_size"
    t.datetime "image_c4_updated_at"
    t.string   "image_c5_file_name"
    t.string   "image_c5_content_type"
    t.integer  "image_c5_file_size"
    t.datetime "image_c5_updated_at"
    t.text     "world"
    t.string   "file_patch_file_name"
    t.string   "file_patch_content_type"
    t.integer  "file_patch_file_size"
    t.datetime "file_patch_updated_at"
    t.integer  "price",                     default: 0
    t.integer  "pend",                      default: 0
    t.integer  "bought",                    default: 0
    t.integer  "bought_us",                 default: 0
    t.integer  "bought_jp",                 default: 0
    t.string   "file_exe_try_file_name"
    t.string   "file_exe_try_content_type"
    t.integer  "file_exe_try_file_size"
    t.datetime "file_exe_try_updated_at"
    t.text     "strage_m"
    t.text     "strage_r"
    t.text     "cpu_m"
    t.text     "cpu_r"
    t.string   "cover_d_file_name"
    t.string   "cover_d_content_type"
    t.integer  "cover_d_file_size"
    t.datetime "cover_d_updated_at"
    t.string   "thumb_d_file_name"
    t.string   "thumb_d_content_type"
    t.integer  "thumb_d_file_size"
    t.datetime "thumb_d_updated_at"
    t.text     "title_s"
  end

  add_index "demos", ["user_id"], name: "index_demos_on_user_id", using: :btree

  create_table "evangelists", force: :cascade do |t|
    t.string   "title"
    t.text     "post_short"
    t.text     "post"
    t.integer  "user_id"
    t.integer  "demo_id"
    t.datetime "created_at",                                                                                                     null: false
    t.datetime "updated_at",                                                                                                     null: false
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "user_name"
    t.string   "thumb_e_file_name"
    t.string   "thumb_e_content_type"
    t.integer  "thumb_e_file_size"
    t.datetime "thumb_e_updated_at"
    t.string   "cover_e_file_name"
    t.string   "cover_e_content_type"
    t.integer  "cover_e_file_size"
    t.datetime "cover_e_updated_at"
    t.text     "title_s"
    t.integer  "views",                default: 0
    t.integer  "views_e",              default: 0
    t.integer  "likes_e",              default: 0
    t.text     "paragraph1"
    t.text     "paragraph2"
    t.text     "paragraph3"
    t.text     "paragraph4"
    t.text     "paragraph5"
    t.text     "paragraph6"
    t.text     "paragraph7"
    t.integer  "array_l",              default: [],                                                                                           array: true
    t.text     "cited_from"
    t.string   "slug"
    t.boolean  "is_public"
    t.string   "yt"
    t.string   "yt_id"
    t.string   "yt_img0",              default: "https://i.graphnote.com/images/120/medium/pexels-photo-119685.jpeg?1471388976"
    t.string   "yt_img1"
    t.string   "yt_img2"
    t.string   "yt_img3"
    t.float    "rating",               default: 0.0
    t.integer  "come_e",               default: 0
    t.string   "prime_tag",            default: ""
    t.integer  "taglock",              default: 0
    t.integer  "cate",                 default: 0
    t.integer  "r18",                  default: 0
    t.string   "yt_duration",          default: "05:25"
    t.datetime "c_updated_at"
    t.text     "extra",                default: ""
    t.integer  "pend",                 default: 0
    t.integer  "bought",               default: 0
    t.integer  "str_count",            default: 1
    t.integer  "a_str",                default: [],                                                                                           array: true
  end

  add_index "evangelists", ["demo_id"], name: "index_evangelists_on_demo_id", using: :btree
  add_index "evangelists", ["slug"], name: "index_evangelists_on_slug", using: :btree
  add_index "evangelists", ["title"], name: "index_evangelists_on_title", unique: true, using: :btree
  add_index "evangelists", ["user_id"], name: "index_evangelists_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "funds", force: :cascade do |t|
    t.integer  "demo_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "funds", ["demo_id"], name: "index_funds_on_demo_id", using: :btree
  add_index "funds", ["user_id"], name: "index_funds_on_user_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "urls"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "evangelist_id"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "playlist_num",  default: 0
    t.integer  "playorder",     default: 0
    t.integer  "playlist_id"
  end

  add_index "likes", ["evangelist_id"], name: "index_likes_on_evangelist_id", using: :btree
  add_index "likes", ["playlist_id"], name: "index_likes_on_playlist_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "mikus", force: :cascade do |t|
    t.float    "feeling",    default: 0.5
    t.text     "states",     default: "learning it"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "mikutalks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "user_name",    default: "Nanasi"
    t.text     "body"
    t.text     "question"
    t.text     "keyword",      default: [],                    array: true
    t.text     "answear"
    t.float    "useful",       default: 0.5
    t.text     "waiting_for",  default: ""
    t.text     "waiting_word", default: [],                    array: true
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "ab",           default: [],                    array: true
  end

  add_index "mikutalks", ["user_id"], name: "index_mikutalks_on_user_id", using: :btree

  create_table "onlineforms", force: :cascade do |t|
    t.text     "title",      default: ""
    t.text     "body"
    t.integer  "disclose",   default: 0
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "whatkind",   default: 0
  end

  add_index "onlineforms", ["user_id"], name: "index_onlineforms_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.text     "body"
    t.integer  "vote"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id", using: :btree

  create_table "playseeds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "playlist_id"
    t.integer  "listorder"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "playseeds", ["playlist_id"], name: "index_playseeds_on_playlist_id", using: :btree
  add_index "playseeds", ["user_id"], name: "index_playseeds_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.string   "sub_id"
    t.string   "cus_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "speaks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "ucategorizations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ucategorizations", ["category_id"], name: "index_ucategorizations_on_category_id", using: :btree
  add_index "ucategorizations", ["user_id"], name: "index_ucategorizations_on_user_id", using: :btree

  create_table "uploads", force: :cascade do |t|
    t.integer  "evangelist_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "uploads", ["evangelist_id"], name: "index_uploads_on_evangelist_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "",          null: false
    t.string   "encrypted_password",      default: "",          null: false
    t.string   "user_name",               default: "",          null: false
    t.integer  "gill",                    default: 10,          null: false
    t.integer  "lv",                      default: 1,           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",         default: 0,           null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "image_u_id"
    t.integer  "image_u_size"
    t.integer  "eva_id",                  default: 0
    t.integer  "stripe_1",                default: 0
    t.string   "publishable_key"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_code"
    t.integer  "array_b",                 default: [],                       array: true
    t.string   "image_user_file_name"
    t.string   "image_user_content_type"
    t.integer  "image_user_file_size"
    t.datetime "image_user_updated_at"
    t.string   "cover_u_file_name"
    t.string   "cover_u_content_type"
    t.integer  "cover_u_file_size"
    t.datetime "cover_u_updated_at"
    t.integer  "user_cate",               default: 99
    t.string   "slug"
    t.integer  "history",                 default: [],                       array: true
    t.integer  "full_history",            default: [],                       array: true
    t.integer  "playlist_now",            default: 0
    t.string   "bio",                     default: ""
    t.string   "twitter",                 default: ""
    t.string   "facebook",                default: ""
    t.string   "youtube",                 default: ""
    t.string   "soundcloud",              default: ""
    t.string   "deviantart",              default: ""
    t.string   "pixiv",                   default: ""
    t.integer  "price",                   default: 0
    t.integer  "paid",                    default: 0
    t.string   "urls"
    t.string   "period",                  default: "irregular"
    t.text     "message",                 default: "Thanks :)"
    t.string   "cus_id"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_name"], name: "index_users_on_user_name", using: :btree

  create_table "words", force: :cascade do |t|
    t.text     "name"
    t.text     "parent",      default: [],                  array: true
    t.text     "child",       default: [],                  array: true
    t.float    "feel",        default: 0.5
    t.text     "traits",      default: [],                  array: true
    t.text     "look",        default: [],                  array: true
    t.text     "shape",       default: [],                  array: true
    t.text     "color",       default: [],                  array: true
    t.text     "sound",       default: [],                  array: true
    t.text     "touchs",      default: [],                  array: true
    t.text     "temperature", default: [],                  array: true
    t.text     "taste",       default: [],                  array: true
    t.text     "syno",        default: [],                  array: true
    t.text     "unsyno",      default: [],                  array: true
    t.text     "before",      default: [],                  array: true
    t.text     "after",       default: [],                  array: true
    t.text     "personality", default: [],                  array: true
    t.text     "tool",        default: [],                  array: true
    t.text     "onething",    default: [],                  array: true
    t.text     "parts",       default: [],                  array: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "smell",       default: [],                  array: true
    t.string   "pos",         default: "noun"
    t.text     "noun"
    t.text     "verb"
    t.text     "adj"
    t.text     "adv"
  end

  add_index "words", ["name"], name: "index_words_on_name", using: :btree

  add_foreign_key "bantags", "categories"
  add_foreign_key "bantags", "users"
  add_foreign_key "categorizations", "categories"
  add_foreign_key "categorizations", "evangelists"
  add_foreign_key "comments", "demos"
  add_foreign_key "comments", "users"
  add_foreign_key "conversations", "evangelists"
  add_foreign_key "conversations", "users"
  add_foreign_key "demos", "users"
  add_foreign_key "evangelists", "demos"
  add_foreign_key "evangelists", "users"
  add_foreign_key "funds", "demos"
  add_foreign_key "funds", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "likes", "evangelists"
  add_foreign_key "likes", "playlists"
  add_foreign_key "likes", "users"
  add_foreign_key "mikutalks", "users"
  add_foreign_key "onlineforms", "users"
  add_foreign_key "playlists", "users"
  add_foreign_key "playseeds", "playlists"
  add_foreign_key "playseeds", "users"
  add_foreign_key "ucategorizations", "categories"
  add_foreign_key "ucategorizations", "users"
  add_foreign_key "uploads", "evangelists"
end
