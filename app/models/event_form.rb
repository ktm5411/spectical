class EventForm
  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :event

  attribute :name, String
  attribute :all_day

  attribute :start_at, Date

  attribute :start_at_hours, String, default: '00'
  attribute :start_at_minutes, String, default: '00'

  attribute :end_at, Date
  attribute :end_at_hours, String, default: '00'
  attribute :end_at_minutes, String, default: '00'

  attribute :recurring_rule, String
  attribute :end_at, Date

  validates :name, presence: true
  validates_numericality_of :end_at_minutes, :start_at_minutes, less_than_or_equal_to: 60, more_than_or_equal_to: 0
  validates_numericality_of :end_at_hours, :start_at_hours, less_than_or_equal_to: 12, more_than_or_equal_to: 0

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def start_at_hours
    if start_at and start_at.class == DateTime
      start_at.strftime('%H')
    else
      '00'
    end
  end

  def start_at_minutes
    if start_at and start_at.class == DateTime
      start_at.strftime('%M')
    else
      '00'
    end
  end

  def end_at_hours
    if end_at and end_at.class == DateTime
      end_at.strftime('%H')
    else
      '00'
    end
  end

  def end_at_minutes
    if end_at and end_at.class == DateTime
      end_at.strftime('%M')
    else
      '00'
    end
  end

  private

  def persist!
    @event = Event.create name: name,
                          start_at: DateTime.parse("#{start_at} #{start_at_hours}:#{start_at_minutes}"),
                          end_at: DateTime.parse("#{end_at} #{end_at_hours}:#{end_at_minutes}"),
                          all_day: all_day
  end
end
