class Search::Director < Search
  has_many :results, class_name: Creator
end
