class Event < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :calendars

  validates_presence_of :start_at

  attr_accessor :start_at_hours, :start_at_minutes, :end_at_hours, :end_at_minutes
  before_save :set_recurring_rule
  accepts_nested_attributes_for :calendars

  def recurring
    JSON.parse(recurring_rule)
  end

  private
  def set_recurring_rule
    if self.recurring_rule.in? ['', 'null', 'false']
      self.recurring_rule = nil
    end
  end
end
