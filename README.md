# CastleApp by Tomasz Trzos

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
