class Person < ActiveRecord::Base
  has_many :readers
  has_many :posts, :through => :readers
  has_many :posts_with_no_comments, :through => :readers, :source => :post, :include => :comments, :conditions => 'comments.id is null'

  has_many :references
  has_many :jobs, :through => :references
  has_one :favourite_reference, :class_name => 'Reference', :conditions => ['favourite=?', true]
  has_many :posts_with_comments_sorted_by_comment_id, :through => :readers, :source => :post, :include => :comments, :order => 'comments.id'
end
