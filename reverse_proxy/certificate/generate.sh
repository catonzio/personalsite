if [[ $# -ne 1 ]]
then
    echo "You must insert the name of the domain, e.g. 'example.com'"
    exit 1
fi

domain="$1"

sudo certbot certonly --standalone -d "$domain"