# frozen_string_literal: true

class Billing < ApplicationRecord
  validates :name, :email, :document, :amount, :due_date, :uuid, presence: true
  validates :uuid, uniqueness: true

  scope :by_due_date, ->(due_date) { where(due_date: due_date) }
  scope :not_sent, -> { where(sent: false) }
end
