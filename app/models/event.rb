class Event < ActiveRecord::Base
  has_and_belongs_to_many :categories
  #serialize :recurring_rule, Hash
  validates_presence_of :start_at

  attr_accessor :start_at_hours, :start_at_minutes, :end_at_hours, :end_at_minutes
  before_save :set_recurring_rule

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
