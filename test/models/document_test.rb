# == Schema Information
#
# Table name: documents
#
#  id          :uuid             not null, primary key
#  name        :string
#  storage_url :string
#  content     :text
#  status      :integer          default("pending"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
