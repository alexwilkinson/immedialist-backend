# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    name "The Best Book Ever"
    release_date "2034-09-12"
    isbn "1234567890"
    cover_link "link_url"

    factory :real_book do
      name "The Goldfinch"
      isbn "0316055433"
      goodreads_id "17333223"
    end

    factory :fake_book do
      name "The Greatest Book in the World: This is a Tribute"
      goodreads_id "ithinkicanithinkicanithinkican"
    end
  end
end
