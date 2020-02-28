class ChangeLimitFieldsToIntegers < ActiveRecord::Migration[6.0]
  def up
    change_column :workshops, :tlimit, 'integer USING CAST(age AS integer)'
    change_column :workshops, :slimit, 'integer USING CAST(age AS integer)'
  end

  def down
    change_column :workshops, :tlimit, 'string USING CAST(age AS string)'
    change_column :workshops, :slimit, 'string USING CAST(age AS string)'
  end
end
