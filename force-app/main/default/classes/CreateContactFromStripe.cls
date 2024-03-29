/*
string jsonstring = '{'+
  '"id": "evt_1KGRUPSGp1yQXzoNfl7qWpU2",'+
  '"object": "event",'+
  '"api_version": "2020-08-27",'+
  '"created": 1641835021,'+
  '"data": {'+
    '"object": {'+
      '"id": "cus_KwK8kAVfizEt1P",'+
      '"object": "customer",'+
      '"address": {'+
        '"city": "Hyderabad",'+
        '"country": "IN",'+
        '"line1": "Test Line 1",'+
        '"line2": "Test Line 2",'+
        '"postal_code": "500081",'+
        '"state": "TG"'+
      '},'+
      '"balance": 0,'+
      '"created": 1641835021,'+
      '"currency": null,'+
      '"default_source": null,'+
      '"delinquent": false,'+
      '"description": "Testing Stripe customer creation in salesforce",'+
      '"discount": null,'+
      '"email": "teststripe@test.com",'+
      '"invoice_prefix": "95468FB4",'+
      '"invoice_settings": {'+
        '"custom_fields": null,'+
        '"default_payment_method": null,'+
        '"footer": null'+
      '},'+
      '"livemode": false,'+
      '"metadata": {'+
        
      '},'+
      '"name": "Test Customer From Stripe",'+
      '"next_invoice_sequence": 1,'+
      '"phone": "+911234512345",'+
      '"preferred_locales": ['+
        
      '],'+
      '"shipping": {'+
        '"address": {'+
         '"city": "Hyderabad",'+
          '"country": "IN",'+
          '"line1": "Test Line 1",'+
          '"line2": "Test Line 2",'+
          '"postal_code": "500081",'+
          '"state": "TG"'+
        '},'+
        '"name": "Test Customer From Stripe",'+
        '"phone": "+911234512345"'+
      '},'+
      '"tax_exempt": "none"'+
   '}'+
  '},'+
  '"livemode": false,'+
  '"pending_webhooks": 3,'+
  '"request": {'+
    '"id": "req_VIq9UVprUPJ6vb",'+
    '"idempotency_key": "ac0a7758-047b-4f6a-9a16-1d02e6ca220a"'+
  '},'+
  '"type": "customer.created"'+
'}';
*/
@RestResource(urlMapping = '/stripe/webhooks/v1/*')
global class CreateContactFromStripe {
    @HttpPost
    global static void doPost(){
        String jsonString = RestContext.request.requestBody.toString();
        RestResponse resp = RestContext.response;
        resp.addHeader('Content-Type', 'application/json');
        system.debug('jsonString'+jsonString);
        resp.statusCode = 200;
        resp.responseBody = Blob.valueOf('{success : true, event : "unknown"}');
        
        JSONParser parser = JSON.createParser(jsonString);
        string name = '';
        string phone = '';
        string email = '';
        while (parser.nextToken() != null) {
           // System.debug('** parser.getCurrentToken() **'+parser.getCurrentToken());
            //System.debug('** JSONToken.FIELD_NAME **'+JSONToken.FIELD_NAME);
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME && 
                (parser.getText() == 'name')){ 
               // Get the value.
                parser.nextToken();
                name = parser.getText();
                system.debug('** name **'+name);                
            }
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME && 
                (parser.getText() == 'phone')){ 
               // Get the value.
                parser.nextToken();
                phone = parser.getText();
                system.debug('** phone **'+phone);                
            }
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME && 
                (parser.getText() == 'email')){ 
               // Get the value.
                parser.nextToken();
                email = parser.getText();
                system.debug('** email **'+email);                
            }
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME && 
                (parser.getText() == 'line2')){ 
               // Get the value.
                parser.nextToken();
                string line2 = parser.getText();
                system.debug('** line2 **'+line2);                
            }
        }
        Contact con = new Contact(lastname=name,phone=phone,email=email);
        insert con;
        system.debug('** contact id **'+con.id);
    }
    
    global static string doGet(){
        return '{"message" : "Public API Success"}';
    }
    
}