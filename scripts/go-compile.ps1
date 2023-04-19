# go-compile.ps1

function pretty_echo {
    Write-Host -NoNewline -ForegroundColor Magenta "-> "
    Write-Host $args[0]
}

# What to compile...
$TARGET = $args[0]
if ([string]::IsNullOrEmpty($TARGET)) {
    Write-Host " Usage: $($MyInvocation.InvocationName) <go package name>"
    exit 1
}

# Install direct code dependencies
pretty_echo "Installing '$TARGET' dependencies"

go get -v $TARGET
$RESULT = $LASTEXITCODE
if ($RESULT -ne 0) {
    Write-Host "   ... error"
    exit $RESULT
}

# Compile / Install the server
pretty_echo " Compiling '$TARGET'"

go install -v $TARGET
$RESULT = $LASTEXITCODE
if ($RESULT -eq 0) {
    Write-Host "   ... done"
    exit 0
} else {
    Write-Host "   ... error"
    exit $RESULT
}