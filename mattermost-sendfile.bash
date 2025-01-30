#!/bin/bash

if [[ -z ${1} ]]; then
  echo -e "\e[31mFILENAME not specified ! \e[mUsage: $(basename $0) <FILENAME> <MESSAGE>"
  exit 1
fi
if [[ -z ${2} ]]; then
  echo -e "\e[31;1mMESSAGE not specified. Proceeding with empty message.\e[m"
  MESSAGE=""
else
  MESSAGE="$2"
fi

# ---

FILENAME="$1"
MATTERMOST_URL='https://YOUR-HOST-URL'
CHANNEL_ID='<CHANNEL ID>'
PERSONAL_TOKEN='<PERSONAL TOKEN WITH PERMISSION TO POST MESSAGE TO CHANNEL'

# ---

POST_RESPONSE=$(curl \
  --silent \
  --location \
  --request POST \
  ${MATTERMOST_URL}/api/v4/files?channel_id=${CHANNEL_ID} \
  --header "Authorization: Bearer ${PERSONAL_TOKEN}" --header "Content-Type: multipart/form-data" --form "files=@${1}")


POST_RESPONSE=$(curl \
  --silent \
  --location \
  --request POST \
  ${MATTERMOST_URL}/api/v4/posts \
  --header "Authorization: Bearer ${PERSONAL_TOKEN}" \
  --header "Content-Type: application/json" \
  --data "{\"file_ids\":[\"$(echo $POST_RESPONSE | jq -r .[].[].id)\"],\"message\":\"${MESSAGE}\",\"channel_id\":\"${CHANNEL_ID}\"}")
