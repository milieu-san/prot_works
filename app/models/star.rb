class Star < ApplicationRecord
  belongs_to :giving, class_name: "User"
  belongs_to :taking, class_name: "User"
end
