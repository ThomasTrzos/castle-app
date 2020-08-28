import time
from locust import HttpUser, task, between
from faker import Faker


class QuickstartUser(HttpUser):
    wait_time = between(1, 2)

    @task
    def index_page(self):
        faker = Faker()
        email = faker.safe_email()
        ip = faker.ipv4()
        self.client.get(
            f"/api/v1/authentication_events/analyse?api_token=54f027fe-fe8d-4793-82be-ecb86f06e691&event_name=login_failed&ip_address={ip}&email={email}")
