# Beachfront Docker

Dockerizing Beachfront microservices

# Running

From this root directory, run `docker-compose up` and then wait a while.

Once up, access the Beachfront UI at `localhost:8080`

_Caveat_: Upon logging in through the OAuth and receiving a valid authentication token, you will be redirected outside of the `localhost` instance of Beachfront. At that point, simply hijack the URL back to `localhost:8080/?logged_in=true` to access the session locally. __TODO__: Mock the OAuth flow as well. 