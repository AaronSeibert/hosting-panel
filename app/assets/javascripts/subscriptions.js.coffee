# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

onSubscriptionsLoad = ->
  $("#subscription_client").typeahead [
    name: "clients"
    valueKey: "name"
    remote: "/clients/search.json?q=%QUERY"
  ]
  
  $('#subscription_bill_now').change updateInitialPayment
  $('#subscription_bill_now').change()
  $('#subscription_plan_id').change updatePlanInfo
  $('#subscription_plan_id').change()
  $('#subscription_quantity').change updatePriceInfo
  
updateInitialPayment = ->
  if ($('#subscription_bill_now').is(':checked'))
    url = CURRENT_DOMAIN + '/plans/' + $('#subscription_plan_id').val() + '.json'
    $.getJSON url, (data) ->
      $('#prorated_charge').html(data.prorated_charge*$('#subscription_quantity').val()).formatCurrency()
  else
    $('#prorated_charge').html('0').formatCurrency()
  
updatePriceInfo = ->
  url = CURRENT_DOMAIN + '/plans/' + $('#subscription_plan_id').val() + '.json'
  $.getJSON url, (data) ->
    $('#price').html(data.price*$('#subscription_quantity').val()).formatCurrency()
    $('#prorated_charge').html(data.prorated_charge*$('#subscription_quantity').val()).formatCurrency()
    updateInitialPayment
    
updatePlanInfo = ->
  url = CURRENT_DOMAIN + '/plans/' + $('#subscription_plan_id').val() + '.json'
  $.getJSON url, (data) ->
    $('#price').html(data.price*$('#subscription_quantity').val()).formatCurrency()
    $('#subscription_next_bill_date').val(dateFormat(data.next_bill_date, "yyyy-mm-dd"))
    $('#prorated_charge').html(data.prorated_charge*$('#subscription_quantity').val()).formatCurrency()
    updateInitialPayment
    
    if data.multiple
      $("#subscription_quantity").prop "disabled", false
    else
      $("#subscription_quantity").prop "disabled", true
    
setClientID = (data) ->
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
