<h1 align="center">
  CastleApp by Tomasz Trzos
</p>

## General Information

- Ruby 2.7.1
- Rails 6.0.3
- PostgreSQL 12.2
- Redis 4.0.14

## Installation

**1. Get the code. Clone this git repository:**

```
git clone git@github.com:ThomasTrzos/castle-app.git
cd castle-app
```

**2. Download and install Docker on your local machine**

- **windows:** https://docs.docker.com/docker-for-windows/install/
- **mac os:** https://docs.docker.com/docker-for-mac/install/

**3. Run Docker deamon on your local machine**

**4. Build images from docker-compose file**

```
docker-compose build
```

**5. Create development and test database**

```
docker-compose run web rails db:create
```

**6. Run migrations**

```
docker-compose run web rails db:migrate
```

**7. Run seeds to create sample Organization and IpBanSettingsSet**

```
docker-compose run web rails db:seed
```

**8. Run web application, postgres and redis server**

```
docker-compose up
```

### Running the tests

**1. Run all tests using this command**

```
docker-compose run web bundle exec rspec spec
```

### Task description

> Credential stuffing is the process where an attacker tries to validate a list of stolen email/password combinations in as short time as possible. Given an event name, an IP address and an email address as input, build a rate limiting app that bans an IP address for a X seconds when Y failed requests has been observed within the last Z seconds using N different emails.

> All of the parameters should be configurable.

> Example input: "login_failed", "1.1.1.1", "test@example.com"

### Database structure

<p align="center">
  <img src="https://i.ibb.co/pZ0LmR3/database-diagram.png" width="200">
</p>

Organization is an object to save a client's data. When we create an organization we also generate api_token which is used by a client to communicate with our system.

If you want to get an api_token for testing purposes please get organization's api token through rails console.

Every organisation needs a IpBanSettingsSet which contains settings how our system should work for client's website.

Organization X seconds when Y failed requests has been observed within the last Z seconds using N different emails

### Sample request and responses

```
GET /api/v1/authentication_events/analyse?api_token=2ee2cb2b-6d64-41d3-b9f1-bd68f22d6f48&event_name=login_failed&ip_address=216.150.182.208&email=sample-user@email.com
```

_case 1: system doesn't ban user's ip address_

```json
HTTP Code: 200

{
  "message": "Next login request permitted."
}
```

_case 2: system banned user's ip address for X seconds_

```json
HTTP Code: 200

{
  "message": "User hits login limitations. Ip address banned for 10 seconds."
}
```

_case 3: wrong api_token_

```json
HTTP Code: 401

{
  "error": "Invalid ApiToken"
}
```

_case 4: wrong event name (for now only login_failed is valid)_

```json
HTTP Code: 422

{
  "event_name": ["must be equal to login_failed"]
}
```

_case 5: no ip_address_

```json
HTTP Code: 422

{
  "ip_address": ["must be filled"]
}
```

_case 6: no email_

```json
HTTP Code: 422

{
  "email": ["must be filled"]
}
```

## API

|               Endpoint                |                  Params                  | Method |                                                  Description                                                  |
| :-----------------------------------: | :--------------------------------------: | :----: | :-----------------------------------------------------------------------------------------------------------: |
|                   /                   |                                          |  GET   |                                           root, name of the project                                           |
| /api/v1/authentication_events/analyse | api_token, event_name, ip_address, email |  GET   | analyse provided user's data and returns http code: 200 if request is allowed by the system or 403 if doesn't |

## Ideas for future extensions

- deploy application to the Kubernetes Engine in Google Cloud Platform
- add Stackdriver for logs and resources monitoring
- add NewRelic or Datadog for monitoring rails application on production environment

## Authors

Tomasz Trzos

## License

© 2020 Tomasz Trzos all rights reserved.
