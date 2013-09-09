$ ()->
  $('.datepicker').datepicker({
    dateFormat: "yy-mm-dd"
  })

  $('#calendar').fullCalendar({
    events: '/events/schedule.json'
  })