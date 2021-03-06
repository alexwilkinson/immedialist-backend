require 'rails_helper'

RSpec.describe CreateListItem, type: :service do
  context 'given any list item' do
    context 'with a requested item associated' do
      let(:list_item) { FactoryGirl.build(:list_item,
                                          name: "Generic Query",
                                          item: item) }
      let(:item) { FactoryGirl.build(:requested_item, requested_type: "Movie") }

      it 'returns a saved list item' do
        VCR.use_cassette('generic_list_item_query') do
          CreateListItem.call(list_item)

          expect(list_item).to be_persisted
        end
      end
    end

    context 'without a requested item associated' do
      let(:list_item) { FactoryGirl.build(:list_item,
                                          name: "Generic Query",
                                          item: nil) }

      it 'does not save the list item and adds errors' do
        CreateListItem.call(list_item)

        expect(list_item).to_not be_persisted
        expect(list_item.errors[:item]).to be_present
      end
    end

    context 'with an item other than a RequestedItem associated' do
      let(:list_item) { FactoryGirl.build(:list_item,
                                          name: "Awesome Movie",
                                          item: item) }
      let(:item) { FactoryGirl.build(:movie, name: "Awesome Movie") }

      it 'does not save the list item and adds errors' do
        CreateListItem.call(list_item)

        expect(list_item).to_not be_persisted
        expect(list_item.errors[:item]).to be_present
      end
    end

    context 'with a ListItem that fails its model validations' do
      let(:list_item) { FactoryGirl.build(:list_item,
                                          name: nil,
                                          item: item) }
      let(:item) { FactoryGirl.build(:requested_item, requested_type: "Movie") }

      it 'does not save the list item and adds errors' do
        CreateListItem.call(list_item)

        expect(list_item).to_not be_persisted
        expect(list_item.errors).to be_present
      end
    end
  end

  context 'when the list item name yields query results' do
    let(:list_item) { FactoryGirl.build(:list_item,
                                        name: "The Matrix",
                                        item: item) }
    let(:item) { FactoryGirl.build(:requested_item, requested_type: "Movie") }

    it 'attaches relevant results to the list item' do
      VCR.use_cassette('real_name_movie_query') do
        CreateListItem.call(list_item)
        search_results = list_item.search.results

        expect(search_results).to_not be_empty
        expect(search_results.map(&:class).uniq).to eq([Movie])

        relevant_movie = search_results.select do |m|
          m.name == "The Matrix"
        end

        expect(relevant_movie).to_not be_nil
      end
    end
  end
end
