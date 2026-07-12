LATEST_TAG_VERSION=`curl -s https://api.github.com/repos/NyarchLinux/NyarchLinux/releases/latest | grep "tag_name" | awk -F'"' '/tag_name/ {print $4}'`
RELEASE_LINK="https://github.com/TotallyDIO/NyarcherAccessories/raw/refs/heads/main/"
file_path=/tmp/NyarchLinux.tar.gz
url=${RELEASE_LINK}${LATEST_TAG_VERSION}/NyarchLinux.tar.gz

wget -q -O "$file_path" "$url"
