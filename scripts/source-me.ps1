# source-me.ps1
# Useful variables. Source from the root of the project

# Shockingly hard to get the sourced script's directory in a portable way
$script_name = $MyInvocation.MyCommand.Path
$dir_path = Split-Path -Parent $script_name
$secrets_path = Join-Path $dir_path "..\secret"
if (!(Test-Path $secrets_path)) {
    Write-Host "ERR: ..\secret dir missing!"
    return 1
}

$env:GO111MODULE = "on"
$env:GOBIN = Join-Path $PWD "bin"
$env:GOPATH = Join-Path $env:USERPROFILE "go"
$env:PATH = "$env:PATH;$env:GOBIN;$PWD\tools\protoc-3.6.1\bin"
$env:DOCKER_BUILDKIT = "1"
$env:OPENAI_API_KEY = Get-Content (Join-Path $secrets_path "openai_api_key")
$env:PINECONE_API_KEY = Get-Content (Join-Path $secrets_path "pinecone_api_key")
$env:PINECONE_API_ENDPOINT = Get-Content (Join-Path $secrets_path "pinecone_api_endpoint")

Write-Host "=> Environment Variables Loaded"