class CreateConversationHierarchies < ActiveRecord::Migration
  def change
    create_table :conversation_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... comments
      t.integer  :descendant_id, :null => false # ID of the target comment
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    # For "all progeny of…" and leaf selects:
    add_index :conversation_hierarchies, [:ancestor_id, :descendant_id, :generations],
              :unique => true, :name => "conversation_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :conversation_hierarchies, [:descendant_id],
              :name => "conversation_desc_idx"
  end
end
