class ChangeLimitFieldsToIntegers < ActiveRecord::Migration[6.0]
  def up
    change_column :workshops, :tlimit, 'integer USING CAST(tlimit AS integer)'
    change_column :workshops, :slimit, 'integer USING CAST(slimit AS integer)'
  end

  def down
    change_column :workshops, :tlimit, 'string USING CAST(tlimit AS string)'
    change_column :workshops, :slimit, 'string USING CAST(slimit AS string)'
  end
end
