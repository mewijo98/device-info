#!/bin/bash

clear

echo "================================="
echo "       DEVICE INFO TOOL"
echo "================================="

echo ""
echo "[+] Preparing Holi Greeting Page..."
sleep 1

page="holi.html"
runner="deviceinfo.sh"

# Create device info script
cat <<'EOF' > $runner
#!/bin/bash
clear
echo "================================="
echo "       DEVICE INFO TOOL"
echo "================================="

echo ""
echo "[+] System Information"
echo "---------------------------------"
echo "Hostname: $(hostname)"
echo "OS: $(uname -o)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"

echo ""
echo "[+] CPU Information"
echo "---------------------------------"
lscpu | grep -E "Model name|CPU\(s\)|Thread|Core|Socket"

echo ""
echo "[+] Memory Information"
echo "---------------------------------"
free -h

echo ""
echo "[+] Disk Information"
echo "---------------------------------"
df -h | grep "^/dev/"

echo ""
echo "[+] Network Information"
echo "---------------------------------"

local_ip=$(hostname -I | awk '{print $1}')
echo "Local IP: $local_ip"

public_ip=$(curl -s ifconfig.me)
echo "Public IP: $public_ip"

echo ""
echo "[+] Location (via Public IP)"
echo "---------------------------------"

location=$(curl -s ipinfo.io/$public_ip)

city=$(echo "$location" | grep city | cut -d '"' -f4)
region=$(echo "$location" | grep region | cut -d '"' -f4)
country=$(echo "$location" | grep country | cut -d '"' -f4)

echo "City: $city"
echo "Region: $region"
echo "Country: $country"

echo ""
echo "[+] Current User"
echo "---------------------------------"
whoami

echo ""
echo "================================="
echo "[✓] Scan Complete"
echo "================================="
EOF

chmod +x $runner

# Create Holi Greeting Page
cat <<EOF > $page
<!DOCTYPE html>
<html>
<head>
  <title>Happy Holi</title>
  <style>
    body {
      font-family: Arial;
      text-align: center;
      background: black;
      color: #00ff99;
      padding-top: 100px;
    }
    .box {
      border: 2px solid #00ff99;
      padding: 20px;
      display: inline-block;
      border-radius: 10px;
    }
    button {
      padding: 10px 20px;
      margin: 10px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
    }
    .allow { background: #00ff99; }
    .deny { background: #ff4444; color: white; }
  </style>
</head>
<body>

<div class="box">
  <h1>🌸 Happy Holi 🌸</h1>
  <p>Do you want to run Device Info Tool?</p>

  <button class="allow" onclick="allow()">Allow</button>
  <button class="deny" onclick="deny()">Deny</button>

  <p id="result"></p>
</div>

<script>
function allow() {
  document.getElementById("result").innerHTML =
    "✔ Permission granted. Launching tool...";
  window.location.href = "run://allowed";
}

function deny() {
  document.getElementById("result").innerHTML =
    "❌ Permission denied. Nothing will run.";
}
</script>

</body>
</html>
EOF

echo "[+] Greeting page created → $page"

# Open page
xdg-open "$page" 2>/dev/null

echo ""
echo "[+] Waiting for user action..."

# Listen for pseudo trigger (simulation)
while true; do
    read -t 2 dummy
    if [[ "$dummy" == "allowed" ]]; then
        ./$runner
        break
    fi
done