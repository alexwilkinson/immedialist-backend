class CreateListItem
  include Immedialist::ItemTypeConversion

  def self.call(list_item_params)
    new(list_item_params).call
  end

  def initialize(list_item_params)
    @item_type = ItemType(list_item_params.fetch(:type))
    @name = list_item_params.fetch(:name)
  end

  def call
    ListItem.new(name: name) do |list_item|
      AttachDummyItemToListItem.call(list_item, item_type)
      AttachSearchToListItem.call(list_item)
      AttachQueryResultsToSearch.call(list_item.search)
    end
  end

  private

  attr_reader :item_type, :name
end
