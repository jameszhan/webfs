# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#$(document).tooltip
#  selector: "a[data-toggle=tooltip]"

$(document).on 'click', 'a[data-toggle=modal]', (e)->
  e.preventDefault()
  self = $(this)
  target = $(self.data('target'))
  target.find(".modal-title").text(self.data('title'))
  if self.data("link")
    target.find(".modal-body > iframe").attr('src', self.data('link'))
  target.on "click", '.open-file', (e)->
    $.post "open", path: self.data('uri'), mime: self.data('mime')
  .find('.download-file').attr('href', '/download/inodes/' + self.data('id'))    
  return false
  
  
