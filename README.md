# Beachfront Docker

Dockerizing Beachfront micro-services

## Required Host Environment Variables

There are a couple of host environment variables that cannot be provided within the compose. Please set up these system variables on the host before running Docker.

| Variable | Value |
|---|---|
| PL_API_KEY | The Planet API Key used to search for imagery metadata. This is required if you wish to search for any of Planet data sources. If not provided, then the below (Local Landsat-8)[#local-landsat-8-data-source] steps must be run. |

## Running

From this root directory, run `docker-compose up` and then wait a while as all the services come online.

Once up, access the Beachfront UI at `https://localhost:8080/?logged_in=true`

_Note_: Authentication is completely disabled for this compose setup. Therefore, you must access the UI with the above URL with the `logged_in` flag set to true - otherwise an authentication challenge occurs and no OAuth provider has been established within this deployment. 

## Local Landsat-8 Data Source

The local Landsat-8 index that Beachfront maintains (corresponding with the *Public-Data-Set* drop-down option) will not be initially populated during the initial `up`. In order to populate this local Landsat-8 index then run the following commands:

`docker-compose run iabroker bf-ia-broker landsat_ingest`

and 

`docker-compose run iabroker bf-ia-broker landsat_metadata`

## Note to Windows users

Line endings are very important when running the `docker-compose up`. When moving files around, ensure that all line endings in the scripts are Unix-style using a tool such as `dos2unix`. 
