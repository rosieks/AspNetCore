#!/usr/bin/env bash

if type -P "node" &>/dev/null; then
    echo "node is in \$PATH"
    exit
fi

node_version=$1
echo $uname
if [ "$uname" = "Darwin" ]; then
   platformarch='darwin-x64'
else
   platformarch='linux-x64'
fi
platformarch=$2
output_dir=$HELIX_CORRELATION_PAYLOAD/node
url="http://nodejs.org/dist/v$node_version/node-v$node_version-$platformarch.tar.gz"
tmp="$(mktemp -d -t install-node.XXXXXX)"
trap "rm -rf $tmp" EXIT
cd "$tmp"
curl -Lsfo $(basename $url) "$url"
echo "Installing node from $(basename $url) $url"
mkdir $output_dir
echo "Unpacking to $output_dir"
tar --strip-components 1 -xzf "node-v$node_version-$platformarch.tar.gz" --no-same-owner --directory "$output_dir"

ls -la $output_dir/bin

export PATH="$PATH:$output_dir"
