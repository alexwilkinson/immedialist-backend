class MovieDirector < ActiveRecord::Base
  belongs_to :movie
  belongs_to :creator
end
