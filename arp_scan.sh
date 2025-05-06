W=$(ip a | grep " UP" | cut -d ' ' -f2 | sed 's/://'); macc=$(ifconfig "$W" down; macchanger -r "$W"; ifconfig "$W" up); echo -e "\n\033[0;32m$macc\033[0m"
newip=$(ifconfig | grep "broadcast" | cut -d ' ' -f10); echo -e "\033[0;32m$newip\033[0m"
sleep 1

echo -ne "\n\e[32mIP: \e[0m"
read ip
export ip

echo -ne "\n\e[32mSeq IP: \e[0m"
read seqip
export seqip

echo -e "\n\033[0;32m==============================\033[0m\n"

seq 1 "$seqip" | xargs -I {} -P 5 bash -c '
  arping=$(arping -c 1 -w 2 "$ip.{}" | grep "bytes" | sed "s/: .*//" | cut -d ' ' -f4-5)
  if [ -n "$arping" ]; then
    echo -e "\033[0;32m$arping\033[0m"
  fi'

echo -e "\n\033[0;32m==============================\033[0m\n"

macn=$(ip a | grep " UP" | cut -d ' ' -f2 | sed 's/://'); macc=$(ifconfig "$W" down; macchanger -r "$W"; ifconfig "$W" up); echo -e "\n\033[0;32m$macn\033[0m"
newip=$(ifconfig | grep "broadcast" | cut -d ' ' -f10); echo -e "\033[0;32m$newip\033[0m"
