#!/bin/sh

API_KEY="6636eae9c588a33a7c3c29a1cd993f2554e87216c96cf390461a64183b1dd5e7"
URL="https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,USDT,XMR,SOL&tsyms=USD&api_key=${API_KEY}"

# Function to fetch and display crypto prices
get_crypto_prices() {
    # Fetch data from CryptoCompare API
    response=$(curl -s "$URL")

    # Check for errors
    if [[ $? -ne 0 ]]; then
        echo "Ошибка при получении данных"
        exit 1
    fi

    # Extract and print the prices using jq
    btc=$(echo $response | jq -r '.BTC.USD')
    eth=$(echo $response | jq -r '.ETH.USD')
    usdt=$(echo $response | jq -r '.USDT.USD')
    xmr=$(echo $response | jq -r '.XMR.USD')
    sol=$(echo $response | jq -r '.SOL.USD')

    # echo -e "BTC:\t$btc"
    # echo -e "ETH:\t$eth"
    # echo -e "USDT:\t$usdt"
    # echo -e "XMR:\t$xmr"
    # echo -e "SOL:\t$sol"

    printf "%s$%s" "XMR=" "$xmr"
}

# Call the function
get_crypto_prices