#!/bin/bash

HOME=$(pwd)

function AllInOneDecoder() {
    echo "================================="
    echo "🧠       All-in-One Decoder        🧠"
    echo "================================="
    echo "1️⃣ Manual input string"
    echo "2️⃣ Load string from file"
    echo "3️⃣ Exit"
    read -p "📥 Choose input method: " inputChoice

    if [[ "$inputChoice" == "1" ]]; then
        read -p "🔡 Enter the encoded string: " encoded
    elif [[ "$inputChoice" == "2" ]]; then
        read -p "📂 Enter the file path: " filepath
        if [[ -f "$filepath" ]]; then
            encoded=$(cat "$filepath")
        else
            echo "❌ [!] File not found!"
            return
        fi
    else
        echo "👋 Exiting Decoder..."
        return
    fi

    echo
    echo "---------------------------------"
    echo "🚀 Decoding Attempts Results:"
    echo "---------------------------------"

    echo "🔓 [+] Base64:"
    echo "$encoded" | base64 -d 2>/dev/null || echo "❌ Failed"

    echo
    echo "🔓 [+] Hex:"
    echo "$encoded" | xxd -r -p 2>/dev/null || echo "❌ Failed"

    echo
    echo "🔓 [+] Binary:"
    echo "$encoded" | perl -lpe '$_=pack"B*",$_' 2>/dev/null || echo "❌ Failed"

    echo
    echo "🔓 [+] ROT13:"
    echo "$encoded" | tr 'A-Za-z' 'N-ZA-Mn-za-m'

    echo
    echo "🔓 [+] Base32:"
    echo "$encoded" | base32 -d 2>/dev/null || echo "❌ Failed"

    echo
    echo "✅ Done. Try different formats if this didn’t work."
}

function DataBreatch() {
    echo "================================="
    echo "🕵️‍♂️        Data-Breach Tool         🕵️‍♂️"
    echo "================================="
    echo "1️⃣ h8mail tool"
    echo "2️⃣ haveibeenpwned.com"
    echo "3️⃣ Exit"

    read -p "📥 Select an option: " option

    case $option in
    1)
        echo "🔍 You chose h8mail tool"
        read -p "📧 Enter your email to check for leaks: " mail
        h8mail -t "$mail" > $HOME/leaked?.txt
        echo "📄 Info saved to: leaked?.txt"
        ;;
    2)
        echo "🌐 Opening haveibeenpwned.com in browser..."
        xdg-open "https://haveibeenpwned.com"
        ;;
    3)
        echo "👋 Exiting"
        exit
        ;;
    *)
        echo "❌ Invalid choice, exiting."
        ;;
    esac
}

function ZIPCracking() {
    echo "================================="
    echo "🔐        ZIP Cracking Tool       🔐"
    echo "================================="
    echo "1️⃣ RAR Cracking"
    echo "2️⃣ 7z Cracking"
    echo "3️⃣ ZIP Cracking"
    echo "4️⃣ Exit"

    read -p "📥 Select an option: " option

    case $option in
        1)
            read -p "📂 Enter full path to the RAR file: " file
            if [[ -e "$file" ]]; then
                echo "✅ File is valid. Cracking..."
                rar2john "$file" > /$HOME/hash.txt
                john /$HOME/hash.txt > /$HOME/password.txt
                PASSWORD=(/$HOME/password.txt)
                echo "🔑 $PASSWORD"
            else
                echo "❌ File not valid. Exiting."
            fi
        ;;
        2)
            read -p "📂 Enter full path to the 7z file: " file
            if [[ -e "$file" ]]; then
                echo "✅ File is valid. Cracking..."
                7z2john "$file" > /$HOME/hash.txt
                john /$HOME/hash.txt > /$HOME/password.txt
                PASSW0RD=(/$HOME/password.txt)
                echo "🔑 $PASSWORD"
            else
                echo "❌ File not valid. Exiting."
            fi
        ;;
        3)
            read -p "📂 Enter full path to the ZIP file: " file
            if [[ -e "$file" ]]; then
                echo "✅ File is valid. Cracking..."
                rar2john "$file" > /$HOME/hash.txt
                john /$HOME/hash.txt > /$HOME/password.txt
                PASSWORD=(/$HOME/password.txt)
                echo "🔑 $PASSWORD"
            else
                echo "❌ File not valid. Exiting."
            fi
        ;;
        4) echo "👋 Exiting." ;;
        *) echo "❌ Invalid choice, exiting." ;;
    esac
}

function MetadataExtract() {
    echo "================================="
    echo "📸   Metadata Extraction Tool     📸"
    echo "================================="
    echo "1️⃣ Extract metadata from files (ExifTool)"
    echo "2️⃣ Extract strings from binary files"
    echo "3️⃣ Analyze files for hidden data (Binwalk)"
    echo "4️⃣ Exit"

    read -p "📥 Select an option: " option

    case $option in
        1)
            read -p "📄 Enter file path: " file
            if [[ -f "$file" ]]; then
                exiftool "$file" | tee "metadata_${file}.txt"
            else
                echo "❌ File not found!"
            fi
        ;;
        2)
            read -p "💾 Enter binary file path: " file
            if [[ -f "$file" ]]; then
                strings "$file" | tee "strings_${file}.txt"
            else
                echo "❌ File not found!"
            fi
        ;;
        3)
            read -p "📦 Enter file path: " file
            if [[ -f "$file" ]]; then
                binwalk -e "$file"
                echo "✅ Extracted data saved in _${file}.extracted/"
            else
                echo "❌ File not found!"
            fi
        ;;
        4)
            echo "👋 Returning to Main Menu..."
            sleep 1
            MENU
        ;;
        *) echo "❌ Invalid choice!" ;;
    esac
}

function OSINTRecon() {
    echo "================================="
    echo "🌐         OSINT Tools            🌐"
    echo "================================="
    echo "1️⃣ Find emails & usernames (TheHarvester)"
    echo "2️⃣ Check for breached credentials (H8Mail)"
    echo "3️⃣ Extract website history (Wayback Machine)"
    echo "4️⃣ Automated OSINT Recon (SpiderFoot)"
    echo "5️⃣ Exit"

    read -p "📥 Select an option: " option

    case $option in
        1)
            read -p "🌍 Enter domain name: " domain
            theHarvester -d "$domain" -b all | tee "harvester_${domain}.txt"
        ;;
        2)
            read -p "📧 Enter email to check: " email
            h8mail -t "$email" | tee "h8mail_${email}.txt"
        ;;
        3)
            read -p "🌍 Enter domain name: " domain
            curl -s "http://web.archive.org/cdx/search/cdx?url=${domain}&output=text&fl=original&collapse=urlkey" | tee "wayback_${domain}.txt"
            echo "✅ Archived URLs saved in wayback_${domain}.txt"
        ;;
        4)
            read -p "🌍 Enter target domain/IP: " target
            spiderfoot -m all -q -s "$target" -o spiderfoot_output.html
            echo "✅ OSINT results saved in spiderfoot_output.html"
        ;;
        5)
            echo "👋 Returning to Main Menu..."
            sleep 1
            MENU
        ;;
        *) echo "❌ Invalid choice!" ;;
    esac
}

function InfoGather(){
    echo "=================================="
    echo "🛰️  Information Gathering Menu     🛰️"
    echo "=================================="
    echo "1️⃣ Whois Lookup"
    echo "2️⃣ NsLookup"
    echo "3️⃣ Dig"
    echo "4️⃣ Subdomain Enumeration (Subfinder)"
    echo "5️⃣ DNSRecon"
    echo "6️⃣ Metadata Extraction"
    echo "7️⃣ OSINT Tools"
    echo "8️⃣ Exit"

    read -p "📥 Enter the method number: " method

    case $method in
        1) read -p "🌍 Enter Domain/IP: " domain
           whois "$domain" | tee "whois_${domain}.txt"
        ;;
        2) read -p "🌍 Enter Domain: " domain
           nslookup "$domain" | tee "nslookup_${domain}.txt"
        ;;
        3) read -p "🌍 Enter Domain: " domain
           dig "$domain" | tee "dig_${domain}.txt"
        ;;
        4) read -p "🌍 Enter Domain: " domain
           subfinder -d "$domain" | tee "subfinder_${domain}.txt"
        ;;
        5) read -p "🌍 Enter Domain: " domain
           dnsrecon -d "$domain" | tee "dnsrecon_${domain}.txt"
        ;;
        6) MetadataExtract ;;
        7) OSINTRecon ;;
        8) echo "👋 Returning to Main Menu..."
           sleep 1
           MENU
        ;;
        *) echo "❌ Invalid option!" ;;
    esac
}

function MENU() {
    echo "================================="
    echo "🎯     BXCI Automations Menu      🎯"
    echo "================================="
    echo "1️⃣ Info Gathering"
    echo "2️⃣ Brute Force"
    echo "3️⃣ Metadata Extraction"
    echo "4️⃣ OSINT Tools"
    echo "5️⃣ ZIP Cracking"
    echo "6️⃣ Data Breach Tools"
    echo "7️⃣ All-in-One Decoder"
    echo "8️⃣ Exit"

    read -p "📥 Select an option: " option

    case $option in
        1) InfoGather ;;
        2) BruteForce ;;
        3) MetadataExtract ;;
        4) OSINTRecon ;;
        5) ZIPCracking ;;
        6) DataBreatch ;;
        7) AllInOneDecoder ;;
        8) echo "👋 Exiting..."
           exit ;;
        *) echo "❌ Invalid option!" ;;
    esac
}

MENU
