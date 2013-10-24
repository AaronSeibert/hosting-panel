# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

onSubscriptionsLoad = ->
  $("#subscription_client").typeahead [
    name: "clients"
    valueKey: "name"
    remote: "/clients/search.json?q=%QUERY"
  ]
  
  $('#subscription_plan_id').change updatePlanInfo
  $('#subscription_plan_id').change()
  
updatePlanInfo = ->
  url = CURRENT_DOMAIN + '/plans/' + $('#subscription_plan_id').val() + '.json'
  $.getJSON url, (data) ->
    $('#price').html(data.price).formatCurrency()
    $('#next_bill_date').html(dateFormat(data.next_bill_date, "mmmm dd, yyyy"))
    $('#prorated_charge').html(data.prorated_charge).formatCurrency()
    
setClientID = (data) ->
  console.log(data.id)
  $('#subscription_client_id').val(data.id)

$(document).on 'ajax:success','.new-subscription-modal-form-init', (xhr, data, status) ->
  # do something with `data`, which is a JS object from your JSON response
  onSubscriptionsLoad()
  
$(document).on 'typeahead:selected','#subscription_client', (xhr, data, status) ->
  # do something with `data`, which is a JS object from your JSON response
  setClientID(data)
  
$(document).on 'typeahead:autocompleted','#subscription_client', (xhr, data, status) ->
  # do something with `data`, which is a JS object from your JSON response
  setClientID(data)
