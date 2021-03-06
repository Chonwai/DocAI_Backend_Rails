# == Schema Information
#
# Table name: documents
#
#  id                :uuid             not null, primary key
#  name              :string
#  storage_url       :string
#  content           :text
#  status            :integer          default("pending"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  approval_status   :integer          default("awaiting"), not null
#  approval_user_id  :uuid
#  approval_at       :datetime
#  folder_id         :uuid
#  upload_local_path :string
#
class Document < ApplicationRecord
  resourcify
  acts_as_taggable_on :labels
  enum status: [:pending, :uploaded, :confirmed]
  enum approval_status: [:awaiting, :rejected, :approved]
  has_one_attached :file #, service: :microsoft

  belongs_to :approval_user, optional: true, class_name: "User", foreign_key: "approval_user_id" 

  scope :waiting_approve, lambda { |b|
    where("documents.approval_at is null")
  }

  scope :approved, -> { where("documents.approval_at is not null") }

  def self.last
    order("documents.created_at desc").limit(1).first
  end

  def has_file_uploaded?
    self['storage_url'].present? || file.url.present?
  end

  def update_upload_status
    if self['status'] == "pending" && has_file_uploaded?
      self.status = "uploaded"
      self.save
    end
  end

end
