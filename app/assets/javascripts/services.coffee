$ ->
  services = $('.service-listing .service')
  services.each (index, element) ->
    service = $ element
    service.addClass('collapsed')
    service.find('.title').click ->
      services.addClass('collapsed')
      service.toggleClass('collapsed')
