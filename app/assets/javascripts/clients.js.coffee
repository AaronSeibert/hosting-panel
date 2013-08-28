# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
  
onClientsLoad = ->
  console.log "In onClientsLoad"
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  customer.setupForm()

customer =
  setupForm: ->
    console.log("Overriding form submit")
    $('#new_client').submit ->
      $('input[type=submit]').attr('disabled', true)
      customer.createToken()
      return false;
  
  createToken: ->
    card = 
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.card.createToken(card, customer.handleStripeResponse)
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, customer.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#client_stripe_card_token').val(response.id)
      $('#new_client').trigger("submit.rails")
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)
         
$(document).on 'ajax:success','.new-client-modal-form-init', (xhr, data, status) ->
  # do something with `data`, which is a JS object from your JSON response
  onClientsLoad()