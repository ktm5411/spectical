json.array!(@events) do |event|
  json.title event.name
  json.desc event.description
  json.location event.location
  json.link event.link
  json.address event.address
  json.city event.city
  json.state event.state
  json.phone event.phone
  json.start event.start.to_i
  json.end event.end.to_i
  json.allDay event.all_day? ? true : false
end
