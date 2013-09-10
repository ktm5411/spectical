$ ()->
  $('.datepicker').datepicker({
    dateFormat: "yy-mm-dd"
  })

  $('#calendar').fullCalendar({
    editable: true
    events: '/events/schedule.json'
  })