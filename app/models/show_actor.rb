class ShowActor < ActiveRecord::Base
  belongs_to :show
  belongs_to :creator
end
