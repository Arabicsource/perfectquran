document.addEventListener('turbolinks:load', function() {
  (function(){
    // Custom styling can be passed to options when creating an Element.
    let style = {
      base: {
        // Add your base input styles here. For example:
        // fontSize: '16px',
        // color: "#32325d",
      }
    };
    const stripePublicKey = 'pk_test_gOJJmPkWHKOREug0LCmVVAUB';
    const stripe = Stripe(stripePublicKey);
    const elements = stripe.elements();
    // Create an instance of the card Element
    const card = elements.create('card', {style: style});
    // Add an instance of the card Element into the `card-element` <div>
    card.mount('#card-element');


    card.addEventListener('change', ({error}) => {
      const displayError = document.getElementById('card-errors');
      if (error) {
        displayError.textContent = error.message;
      } else {
        displayError.textContent = '';
      }
    });


    const form = document.getElementById('subscription_form');
    form.addEventListener('submit', async (event) => {
      event.preventDefault();

      const {token, error} = await stripe.createToken(card);

      if (error) {
        // Inform the customer that there was an error
        const errorElement = document.getElementById('card-errors');
        errorElement.textContent = error.message;
      } else {
        // Send the token to your server
        // stripeTokenHandler(token);
        alert(token)
      }
    });
  })();
});