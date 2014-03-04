# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
  
onClientsLoad = ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  customer.setupForm()

customer =
  setupForm: ->
    $('.new_credit_card').parents('form:first').submit ->
      $('input[type=submit]').attr('disabled', true)
      customer.createToken()
      return false;
  
  createToken: ->
    card = 
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
      customer: $('#client_stripe_customer_id').val()
    console.log("Sending Token to Stripe")
    Stripe.card.createToken(card, customer.handleStripeResponse)
    console.log("Received response from Stripe")
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
      customer: $('#client_stripe_customer_id').val()
    Stripe.createToken(card, customer.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#client_stripe_card_token').val(response.id)
      $('.new_credit_card').trigger("submit.rails")
    else
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)
         
$(document).on 'ajax:success','.client-modal-form-init', (xhr, data, status) ->
  # do something with `data`, which is a JS object from your JSON response
  onClientsLoad()