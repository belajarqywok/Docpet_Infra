from locust import HttpUser, task

class main_routes(HttpUser):
    @task
    def main_route(self):
        self.client.get("/api/checker")