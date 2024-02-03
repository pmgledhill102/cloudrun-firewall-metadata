# Cloud Run Firewall Metadata

When running 3rd party components in a Cloud Run container there may be a requirement
to prevent it accessing the container metadata service for security reasons
`'http://metadata.google.internal/computeMetadata/v1/'`.

This can be implemented using `iptables`, installing it as part of the Dockerfile and then
adding the IP filter as part of a start-up script.

Note: It has to use the 2nd generation Cloud Run execution run-time, as the 1st gen is run in
a sandbox that restricts access to certain Linux docker container capabilities.

This repo contains an example implementation. It can be built using Cloud build and deployed
using Cloud Run

```sh
gcloud builds submit --tag europe-west2-docker.pkg.dev/$PROJECT_ID/dev-images/ip-filter
```

And then deployed into Cloud run: 

```sh
gcloud run deploy ip-filter --image europe-west2-docker.pkg.dev/$PROJECT_ID/dev-images/ip-filter --platform managed --region europe-west2 --allow-unauthenticated --execution-environment gen2
```
