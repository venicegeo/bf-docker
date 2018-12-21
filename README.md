# Beachfront Docker

Dockerizing Beachfront micro-services

## Required Host Environment Variables

There are a couple of host environment variables that cannot be provided within the compose. Please set up these system variables on the host before running Docker.

| Variable | Value |
|---|---|
| PL_API_KEY | The Planet API Key used to search for imagery metadata. This is required if you wish to search for any of Planet data sources. If not provided, then the below [Local Landsat-8](#local-landsat-8-data-source) steps must be run. |
| vcap.services.pz-blobstore.credentials.access_key_id | The access key to a public S3 bucket for data transfer use. |
| vcap.services.pz-blobstore.credentials.secret_access_key | The secret key to a public S3 bucket for data transfer use. |
| vcap.services.pz-blobstore.credentials.bucket | The name of a public S3 bucket for data transfer use. |

_Note_: The above-required S3 variables are soon-to-be deprecated and will no longer be needed soon. If no meaningful values are owned, it is acceptable to set these variables to `null` on the host environment. However, without these variables, the results of the Beachfront jobs cannot succeed since the files can't be moved between the microservices without S3. 

## Running

From this root directory, run `docker-compose up` and then wait a while as all the services come online.

Once up, access the Beachfront UI at `https://localhost:8080/?logged_in=true`

_Note_: Authentication is completely disabled for this compose setup. Therefore, you must access the UI with the above URL with the `logged_in` flag set to true - otherwise an authentication challenge occurs and no OAuth provider has been established within this deployment. 

The complete list of local ports will be opened:

| Port | Application | Function |
|---|---|---|
| 8080 | ui | The Beachfront web application user interface. |
| 80 | api | The Beachfront REST API Services. |

## Local Landsat-8 Data Source

The local Landsat-8 index that Beachfront maintains (corresponding with the *Public-Data-Set* drop-down option) will not be initially populated during the initial `up`. In order to populate this local Landsat-8 index then run the following commands *after* the initial `up` has successfully been run:

`docker-compose run iabroker bf-ia-broker migrate && bf-ia-broker landsat_ingest`

and 

`docker-compose run iabroker bf-ia-broker migrate && bf-ia-broker landsat_metadata`

## Note to Windows users

Line endings are very important when running the `docker-compose up`. When moving files around, ensure that all line endings in the scripts are Unix-style using a tool such as `dos2unix`. 

## Docker Resources

This Compose file will start up about a dozen services over half-a-dozen images. To ensure smooth performance, it's highly recommended to check the resources allocated to Docker and increase them to whatever the host machine can support. This configuration has been confirmed functional with 16GB of memory and 3 CPUs. It can function with less, but performance bottlenecks may be encountered. 
