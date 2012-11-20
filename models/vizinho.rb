class Vizinho < ActiveRecord::Base
  attr_accessor :nome, :telefone, :endereco, :numero_endereco

  validates_uniqueness_of :user_id, :telefone, scope: :endereco
  validates_presence_of :nome, :endereco
  

  named_scope :up,   :conditions => ["value = ?", "up"]
  named_scope :down, :conditions => ["value = ?", "down"]
  named_scope :user_id, lambda {|user_id|
    {:conditions => ["user_id = ?", user_id]}}
  named_scope :entry_id, lambda {|entry_id|
    {:conditions => ["entry_id = ?", entry_id]}}
    
  def self.create_or_update(attributes)
    vizinho = Vizinho.find_by_entry_id_and_user_id(attributes[:entry_id], attributes[:user_id])
    if vizinho
      vizinho.value = attributes[:value]
      vizinho.save
      vizinho
    else
      Vizinho.create(attributes)
    end
  end
  
  def self.vizinhod_down_for_user_id(user_id, page, per_page = 25)
    entry_ids_for_user(user_id, "down", page, per_page)
  end
  
  def self.vizinhod_up_for_user_id(user_id, page, per_page = 25)
    entry_ids_for_user(user_id, "up", page, per_page)
  end
  
  def self.entry_ids_for_user(user_id, value, page, per_page)
    vizinhos = paginate_by_user_id_and_value(
      user_id, value, :page => page, :per_page => per_page)
    vizinhos.map {|vizinho| vizinho.entry_id}
  end
end
