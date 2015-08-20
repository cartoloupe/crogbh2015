# unused at the moment -- causing issues with maps
# was used in app/views/servies/categories.html.haml

$ ->
  collapsables = $('.collapsable')
  collapsables.each (index, element) ->
    collapsable = $ element
    collapsable.addClass('collapsed')
    collapsable.find('header').click ->
      collapsables.addClass('collapsed')
      collapsable.toggleClass('collapsed')
