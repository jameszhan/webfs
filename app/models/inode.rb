class Inode < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  mapping do
    indexes :id,            :index    => :not_analyzed
    indexes :shasum,        :analyzer => :not_analyzed
    indexes :content_type,  :analyzer => 'snowball'
    indexes :content_size,  :as       => 'content.size'
    indexes :author,        :analyzer => 'keyword'
    indexes :published_on,  :type => 'date', :include_in_all => false
  end
end
