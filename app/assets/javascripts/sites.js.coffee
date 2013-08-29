# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

updatePlanInfo = ->
  url = CURRENT_DOMAIN + '/plans/' + $('#site_plan_id').val() + '.json'
  $.getJSON url, (data) ->
    $('#price').html(data.price).formatCurrency()
    $('#next_bill_date').html(dateFormat(data.next_bill_date, "mmmm dd, yyyy"))
    $('#prorated_charge').html(data.prorated_charge).formatCurrency()

onSitesLoad = ->
  $('#site_plan_id').change updatePlanInfo
  $('#site_plan_id').change()

$(document).on 'ajax:success','.new-site-modal-form-init', (xhr, data, status) ->
  onSitesLoad()
