# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

onSubscriptionsLoad = ->
  $("#subscription_client").typeahead [
    name: "clients"
    valueKey: "name"
    remote: "/clients/search.json?q=%QUERY"
  ]

$(document).on 'ajax:success','.new-subscription-modal-form-init', (xhr, data, status) ->
  # do something with `data`, which is a JS object from your JSON response
  onSubscriptionsLoad()