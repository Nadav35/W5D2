# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint(8)        not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ApplicationRecord
  
  validates :sub_id, uniqueness: {scope: :post_id}
  
  belongs_to :post
  belongs_to :sub
end
