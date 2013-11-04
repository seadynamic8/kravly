# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  ShareThisTurbolinks.reload()

$(document).on 'page:restore', ->
  ShareThisTurbolinks.restore()

ShareThisTurbolinks =
  load: ->
     window.switchTo5x = false
     $.getScript 'http://w.sharethis.com/button/buttons.js', ->
        window.stLight.options
           publisher: '65f77ed9-0386-4f4f-ac59-1c4b80642bbb'

  reload: ->
     stlib?.cookie.deleteAllSTCookie()
     $('[src*="sharethis.com"], [href*="sharethis.com"]').remove()
     window.stLight = undefined
     @load()

  restore: ->
     $('.stwrapper, #stOverlay').remove()
     @reload()