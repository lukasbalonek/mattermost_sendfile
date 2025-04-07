<#
.SYNOPSIS
    .
.DESCRIPTION
    .
.PARAMETER FILENAME
    File to send.
.PARAMETER MATTERMOST_URL
    URL of your Mattermost instance. For example "https://supermost.com"
.PARAMETER CHANNEL_ID
    ID of channel, where file & message should be posted.
.PARAMETER PERSONAL_TOKEN
    Personal Access Token with permissions to send messages and files to channel.
.PARAMETER MESSAGE
    Message to send with file.
#>

param (
  [Parameter(Mandatory=$true)][string]$FILENAME,
  [Parameter(Mandatory=$true)][string]$MATTERMOST_URL,
  [Parameter(Mandatory=$true)][string]$CHANNEL_ID,
  [Parameter(Mandatory=$true)][string]$PERSONAL_TOKEN,
  [Parameter(Mandatory=$true)][string]$MESSAGE
)

# ---

$POST_RESPONSE = curl.exe `
  --location `
  --request POST `
  ${MATTERMOST_URL}/api/v4/files?channel_id=${CHANNEL_ID} `
  --header "Authorization: Bearer ${PERSONAL_TOKEN}" --header "Content-Type: multipart/form-data" --form "files=@${FILENAME}"

$FILE_IDS = echo $POST_RESPONSE | jq -r .file_infos[].id

$Body = @{
	file_ids = @($FILE_IDS)
	message = $MESSAGE
	channel_id = $CHANNEL_ID	
}
$Momoa = ($Body | ConvertTo-Json -Compress).Replace('"','\"')

$POST_RESPONSE = curl.exe `
  --location `
  --request POST `
  ${MATTERMOST_URL}/api/v4/posts `
  --header "Authorization: Bearer ${PERSONAL_TOKEN}" --header "Content-Type: application/json" `
  --data "$Momoa"
