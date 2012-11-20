class CreateVizinhos < ActiveRecord::Migration
  def self.up
    create_table :vizinhos do |t|
      t.string :nome
      t.string :telefone
      t.string :endereco
      t.string :numero_endereco

      t.timestamps
    end
  end

  def self.down
    drop_table :vizinhos
  end
end