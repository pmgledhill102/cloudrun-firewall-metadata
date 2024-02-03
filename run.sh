#!/bin/bash

# Metadata server base URL
METADATA_SERVER="http://metadata.google.internal"

# Headers to fetch metadata
METADATA_FLAVOR_HEADER="Metadata-Flavor: Google"

# Function to fetch and echo metadata
fetch_metadata() {
  local path="$1"
  local description="$2"
  local value=$(curl -s -H "${METADATA_FLAVOR_HEADER}" "${METADATA_SERVER}${path}")
  echo "${description}: ${value}"
}

# Fetch and output various metadata
fetch_metadata "/computeMetadata/v1/project/project-id" "Project ID"
fetch_metadata "/computeMetadata/v1/instance/zone" "Zone"
fetch_metadata "/computeMetadata/v1/instance/id" "Instance ID"

# Additional metadata can be fetched similarly by adjusting the path and description
