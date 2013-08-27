# Override Rails handling of confirmation

# Create our function for detecting modal form button clicks
bindModalForm = ->
  $(".modal-form").click ->
    href = $(@).attr "href"
    $.get href, (data) ->
      $("#modal-content").html data
      
fadeFlashMessages = ->
  $(".alert").delay(2000).fadeOut(2000)
    
onLoadEvents = ->

  fadeFlashMessages()  
      
$(document).on 'ready page:load', onLoadEvents

# Handle ajax form errors
$(document).on 'ajax:success', 'form[data-remote]', (xhr, data, status) ->
  # do something with `data`, which is a JS object from your JSON response
  $("#modal-window").modal('hide')
  document.open()
  document.write(data)
  document.close()
  
$(document).on 'ajax:error', 'form[data-remote]', (xhr, data, status) ->
  # do something with `data`, which is a JS object from your JSON response
  console.log data

$.rails.allowAction = (element) ->
  # The title is something like "Are you sure?"
  title = element.data('title')
  message = element.data('message')
  # If there's no title, there's no data-confirm attribute, 
  # which means there's nothing to confirm
  return true unless title
  # Clone the clicked element (probably a delete link) so we can use it in the dialog box.
  link = element.clone()
    # We don't necessarily want the same styling as the original link/button.
    .removeAttr('class')
    # We don't want to pop up another confirmation (recursion)
    .removeAttr('data-message')
    .removeAttr('data-title')
    # We want a button
    .addClass('btn').addClass('btn-danger')
    # Remove children
    .html('Delete')
    

  # Create the modal box with the title
  modal_html = """
  <div class="modal fade" id="modal-confirmation">
    <div class="modal-dialog">
      <div class="modal-content">               
        <div class="modal-header">
          <a class="close" data-dismiss="modal">×</a>
          <h3>#{title}</h3>
        </div>
        <div class="modal-body">
          <p>#{message}</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  """
  modal_html = $(modal_html)
  # Add the new button to the modal box
  modal_html.find('.modal-footer').append(link)
  # Pop it up
  modal_html.modal()
  # Prevent the original link from working
  return false