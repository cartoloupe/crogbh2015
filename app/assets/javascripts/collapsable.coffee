$ ->
  collapsables = $('.collapsable')
  collapsables.each (index, element) ->
    collapsable = $ element
    collapsable.addClass('collapsed')
    collapsable.find('header').click ->
      collapsables.addClass('collapsed')
      collapsable.toggleClass('collapsed')
