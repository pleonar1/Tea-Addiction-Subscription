# README

## Tea Addiction Subscription
This is a REST API for a tea subscription service to:
- View a customer's active and cancelled subscriptions
- Create a tea subscription for a customer
- Cancel a subscription

### Primary Technologies


  - Ruby 2.7.4
  - Rails 5.2.8
  - PostgreSQL


### Local Set-Up

Fork and clone this repository to your local machine then

`bundle install`

`rails db:{create,migrate,seed}`


### Testing

Testing is done with [RSpec](https://rspec.info/) with coverage details provided by [SimpleCov](https://github.com/simplecov-ruby/simplecov).

#### Test Suite Execution

`bundle exec rspec`


### Database Design

![Screen Shot 2022-06-03 at 10 08 08 AM](https://user-images.githubusercontent.com/69911294/171870526-e1c176e4-e1f2-4472-b955-77a3f3ea1bd9.png)

### Endpoints

`GET /api/v1/customers/:customer_id/subscriptions`

Response:

```
{
    "id": "10",
    "type": "subscription",
    "attributes": {
        "id": 10,
        "title": "blahblah",
        "price": 400,
        "status": "cancelled",
        "frequency": "Monthly"
    }
},
{
    "id": "11",
    "type": "subscription",
    "attributes": {
        "id": 11,
        "title": "Mr Tea",
        "price": 87.60,
        "status": "active",
        "frequency": "Annually"
    }
}
```


`POST /api/v1/customers/:customer_id/subscriptions`

With the required body:
```
{
  "title": "Paul's Tea",
  "price": 3.11,
  "status": "active",
  "frequency": "monthly",
  "customer_id": 1,
  "tea_id": 1
  }
```
Response:
```
{
  "title": "Paul's Tea",
  "price": 3.11,
  "status": "active",
  "frequency": "monthly",
  "customer_id": 1,
  "tea_id": 1
  }
```

`PATCH /api/v1/customers/:customer_id/subscriptions/:id`
With the required body:
```
{
  "status": "cancelled"
}
```

Response:
```
{
    "id": "5",
    "type": "subscription",
    "attributes": {
        "id": 11,
        "title": "sweet tea",
        "price": 9.99,
        "status": "cancelled",
        "frequency": "Monthly"
    }
}
```

### Contributors

Paul Leonard
