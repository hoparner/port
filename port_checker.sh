#!/bin/bash

GREEN='\e[32m'
RED='\e[31m'
ORANGE='\e[33m'
BLUE='\e[34m'
NC='\e[0m' # No Color

echo -e "${RED}  ■■■■■■■■■■■■ \n ${BLUE} ■■■■■■■■■■■■ \n ${ORANGE} ■■■■■■■■■■■■"
echo -e "${RED}Բարի գալուստ ${NC}IP ${RED}և ${NC}Port ${NC}Checker ${RED}leg${BLUE}ion${ORANGE}_603 ${NC}"
echo -e "${BLUE}Telegram: https://t.me/hoparner ${NC} "
# Language selection
select lang in "English" "Հայերեն" "Русский"; do
  case $lang in
    "English")
      read -p "Enter domain or IP address: " domain
      echo ""
      echo -e "${BLUE}Please wait..."
      echo ""
      break
      ;;
    "Հայերեն")
      read -p "Մուտքագրեք տիրույթը կամ IP հասցեն: " domain
      echo ""
      echo -e "${BLUE}Խնդրում ենք սպասել..."
      echo ""
      break
      ;;
    "Русский")
      read -p "Введите домен или IP-адрес: " domain
      echo ""
      echo -e "${BLUE}Пожалуйста, подождите..."
      echo ""
      break
      ;;
    *)
      echo -e "${RED}Invalid selection. Please try again.${NC}"
      ;;
  esac
done

# Check internet connection
if ! ping -c 1 8.8.8.8 &> /dev/null; then
  case $lang in
    "English")
      echo -e "${RED}No internet connection!${NC}"
      ;;
    "Հայերեն")
      echo -e "${RED}Ինտերնետ կապ չկա՞:${NC}"
      ;;
    "Русский")
      echo -e "${RED}Нет соединения с интернетом!${NC}"
      ;;
  esac
  exit 1
fi

ip=$(ping -c 1 $domain | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')
case $lang in
  "English")
    echo -e "${RED}Current IP address for $domain: $ip${NC}\n"
    ;;
  "Հայերեն")
    echo -e "${RED}$domain-ի ընթացիկ IP հասցեն՝ $ip${NC}\n"
    ;;
  "Русский")
    echo -e "${RED}Текущий IP-адрес для $domain: $ip${NC}\n"
    ;;
esac

# Array of ports to check
ports=(80 443 3306 21 22 23 53 110 25 115 135 139 143 194 445 1433 3306 3389 5632 5900 25565)

# Check the status of each port
for port in "${ports[@]}"; do
  output=$(php -r "\$connection = @fsockopen('$domain', $port, \$errno, \$errstr, 2); if (is_resource(\$connection)) { echo('$GREEN Port $port is open on  $domain $NC\n'); fclose(\$connection); } else { echo('$RED Port $port is closed on $domain $NC\n'); }")
  case $lang in
    "English")
      echo -e "$output"
      ;;
    "Հայերեն")
      echo -e "$output"
      ;;
    "Русский")
      echo -e "$output"
      ;;
  esac
done