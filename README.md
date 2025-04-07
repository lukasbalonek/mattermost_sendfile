# mattermost_sendfile

Simple BASH/PS1 script to send message with attachment to Mattermost instance


## Install

⚠️ `curl` & `jq` is required to run these scripts !

### Debian/Ubuntu

```bash
apt -yq update
apt -yq install jq curl
```

### Windows 10/11

`curl.exe` should be included in every *Windows* starting from version `1909`. 
> ⚠️ `curl` is an *Alias* for `Invoke-WebRequest` !!! You need to execute `curl.exe -V` to make sure you really have a curl.

For `jq`, go to [jqlang.org/download](https://jqlang.org/download/) and download `jq <version> executables for AMD64 or i386`. Install binary to `$env:WINDIR\System32\jq.exe`.
Test functionality by running `jq` in *powershell*.

## Usage

### mattermost-sendfile.bash (Linux)

```bash
./mattermost-sendfile.bash <path-to-file> <message>
```

For example:

```bash
./mattermost-sendfile.bash /var/vid/video9.mp4 "Sending video n9"
```

### mattermost-sendfile.ps1 (Windows)

Run the script interactively and you'll be prompted for every parameter. To display help, use `man .\mattermost-sendfile.ps1`


```powershell
.\mattermost-sendfile.ps1 [-FILENAME] <String> [-MATTERMOST_URL] <String> [-CHANNEL_ID] <String> [-PERSONAL_TOKEN] <String> [-MESSAGE] <String>
```

For example:

```powershell
.\mattermost-sendfile.ps1 -FILENAME D:\videjko.mp4 -MATTERMOST_URL https://supermost.com -CHANNEL_ID bflmpsvzmcbpsnmp -PERSONAL_TOKEN strcprstskrzkrk -MESSAGE "Oh hello, sending the promised video.."
```
