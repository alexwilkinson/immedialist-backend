class ListItemSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :resolved
  has_one :item, polymorphic: true
  has_one :search, polymorphic: true, root: :searches

  def resolved
    search.nil?
  end
end
