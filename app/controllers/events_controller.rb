class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def schedule
    @events = []
    max_date = params[:end] ? Time.new(params[:end]) : Time.now + 3.years

    Event.all.each do |event|
      if not event.recurring_rule
        @events << event
      else
        schedule = IceCube::Schedule.new event.start_at, end_time: max_date
        schedule.add_recurrence_rule IceCube::Rule.from_hash(event.recurring)
        schedule.each_occurrence do |date|
          break if date > max_date or date > event.end_at
          fake_event = event.dup
          fake_event.start_at = date
          @events << fake_event
        end
      end
    end


    render 'schedule', layout: false

  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event_form = EventForm.new
  end

  # GET /events/1/edit
  def edit
    @event_form = EventForm.new @event.attributes
  end

  # POST /events
  # POST /events.json
  def create
    @event_form = EventForm.new params[:event_form]
    respond_to do |format|
      if @event_form.save
        format.html { redirect_to @event_form.event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event_form = EventForm.new params[:event_form]
    respond_to do |format|
      if @event_form.save
        format.html { redirect_to @event_form.event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    #mixin until attr
    #mixed_recurring_rule = JSON.parse(params[:event][:recurring_rule])
    #mixed_recurring_rule[:until] == params[:until]
    #params[:event][:recurring_rule] == mixed_recurring_rule.to_json
    #
    #start_at_time = params[:time][:start_at][:hours]
    params[:event].permit!
  end
end
