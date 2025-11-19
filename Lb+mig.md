
# -_________out of stage______________________________________________________

GLB: moves users automatically to helathy region
DR: ensures your data +systems also survive and can run that other region 
    ex: our app actually
        region A
        regio  B - Backup region
   in GLB if Region A fail the DR immediately send the traffic to region B. That time DR have data,backup area also available in region-b application keeps running if region A- fails


   why we call layer7 load balancer:
   A. it works on actually osi (open system interconnection model).This helps everyone (developers, network engineers, cloud engineers) talk in the same language.
# 
    When you open www.google.com
      all 7 layers work:

     Physical: WiFi/Cable carries signal
     Data Link: MAC address for LAN
     Network: IP address + routing
     Transport: TCP connection on port 443
     Session: Session established
     Presentation: HTTPS decryption 
    Application: Browser sends “GET /search”

    1.you write the message
    2. put in envelop
    3. put adress
    4. give to post office
    5. postman carries it
    6. postman delivers
    7. your friends read the laetter


    L4:

“Send to VM1 or VM2 based ONLY on IP + Port.”

L7:

“Send to VM1, VM2, VM3 based on URL, hostname, path, headers, cookies, SSL, content.”

L4 load balancer can carry HTTP/HTTPS packets, but not read and decrypt  but L7 load balancer can read, understand, and make decisions based on HTTP/HTTPS.




# what is the differnce between static ip and anycast ip
Static IP = regional Ip: one location+regional LB : both internal+external usage
Anycast IP = Global Ip: same IP available worldwide + nearest route + global LB. type of external 

internal Lb: commumicates interenal services 
external Lb: out side expose communication

ALB:
→ Comes in 3 shapes:
Global External ALB (Anycast IP) 
Regional External ALB (Static IP)
Regional Internal ALB (Private IP)


these are the flow:
User → DNS → Google Anycast IP
           ↓
Google LB (closest edge)-it checks below 7 steps the move
           ↓
1. Decrypt HTTPS
2. Check Hostname (www.google.com)
    check:www.google.com-142.3.5.6>fixed ip (Google GLB IP)
3. Check URL (/search)
      Decrypts the HTTPS
      Checks SSL certificate is valid

       Ensures secure connection
4. Check Headers
       are user or bot
       are yoiu come from mobile or desktop
       which language you came
       cookies: create session id inside the browser means if you serach multiple times its alow dont check again and again exmaple we have id card daily i came offce in security ok this person in softility branch go
5. Apply Google Security
       request came from user or hacker
       DDoS = Distributed Denial of Service (lakh of fake requets that time server crash then try to hack server indirectly)
       Lb block to many requests : it show 429 error at website
6. Pick healthy backend
       closesest to user
       not overloaded healthy
7. Forward to Search server
           ↓
Backend server returns result
           ↓
LB
           ↓
User sees Google Search results

STEP 0: DNS
User types www.google.com
        ↓
DNS returns Anycast IP (142.250.xx.xx)
        ↓

STEP 1: Google Edge Load Balancer
        ↓
┌─────────────────────────────────────────────┐
│ 1. Decrypt HTTPS                            │  (HTTPS Proxy)
│ 2. Check Hostname (www.google.com)          │  (URL Map host rule)
│ 3. Check URL (/search)                      │  (URL Map path rule)
│ 4. Check Headers, Cookies, Device           │  (L7 inspection)
│ 5. Security Check (DDoS, Bot, Firewall)     │  (Cloud Armor)
│ 6. Pick healthy backend (Nearest + Healthy) │  (Backend Service + HC)
│ 7. Forward to Search Server                 │  (Chosen backend VM)
└─────────────────────────────────────────────┘
        ↓
Backend Server Processes Response
        ↓
LB returns result to user
        ↓
User sees Google Search Results

┌───────────────────────────────────────────────────────────────────────────────┐
│ 📌 DNS (Domain Name System)                                                   │
│    • User types www.example.com                                               │
│    • DNS resolves → Global Anycast IP                                         │
│    • Browser gets IP like 34.123.55.10                                        │
└───────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌───────────────────────────────────────────────────────────────────────────────┐
│ 📌 GLOBAL ANYCAST IP                                                           │
│    • Same IP available worldwide                                              │
│    • Routes user to nearest Google POP                                        │
└───────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌───────────────────────────────────────────────────────────────────────────────┐
│ ⭐ Google Cloud External HTTP(S) Global Load Balancer (L7 Load Balancer) ⭐   │
│   (Everything below is inside the Load Balancer until Backend Service)   
---the Lb UNDER THESE FOLLOWS------     │
└───────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌───────────────────────────────────────────────────────────────────────────────┐
│ 📌 Forwarding Rule                                                            │
│    • Matches Global IP (Anycast)                                              │
│    • Matches Port (443 HTTPS / 80 HTTP)                                       │
│    • Sends traffic to correct HTTPS/HTTP Proxy                                │
└───────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌───────────────────────────────────────────────────────────────────────────────┐
│ 📌 PROXY (HTTP / HTTPS)                                                       │
│    • TLS/SSL Handshake                                                        │
│    • Decrypt HTTPS → HTTP                                                     │
│    • Reads Hostname (SNI / Host header)                                       │
│    • Reads URL Path (/search, /login)                                         │
│    • Passes request to URL Map                                                │
└───────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌───────────────────────────────────────────────────────────────────────────────┐
│ 📌 URL MAP (Routing Brain)                                                    │
│    • Match Host Rule (www.example.com)                                        │
│    • Match Path Rule (/api, /images)                                          │
│    • Select correct Backend Service                                            │
└───────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌───────────────────────────────────────────────────────────────────────────────┐
│ 📌 CLOUD ARMOR (Security Layer)                                               │
│    • DDoS protection                                                           │
│    • WAF rules (SQLi / XSS blocking)                                          │
│    • Bot filtering                                                             │
│    • Allow / Deny rules                                                       │
└───────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌───────────────────────────────────────────────────────────────────────────────┐
│ 📌 BACKEND SERVICE (Traffic Manager)                                          │
│    • Uses health checks                                                       │
│    • Chooses healthiest VM                                                     │
│    • Chooses nearest region                                                    │
│    • Balances load across VM instances                                        │
└───────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌───────────────────────────────────────────────────────────────────────────────┐
│ 📌 HEALTH CHECK                                                                │
│    • Continuously checks VMs (/health)                               k          │
│    • Only sends traffic to healthy VMs                                         │
└───────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌───────────────────────────────────────────────────────────────────────────────┐
│ 📌 MANAGED INSTANCE GROUP (MIG)                                               │
│    • Auto-scaling                                                             │
│    • Auto-healing                                                             │
│    • Identical instances from template                                        │
└───────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌───────────────────────────────────────────────────────────────────────────────┐
│ 📌 VM INSTANCE / CONTAINER                                                    │
│    • Runs your application                                                     │
│    • Sends response back to user                                               │
└───────────────────────────────────────────────────────────────────────────────┘






notes: 👉 A browser is a software/app you use to open websites.


--------------------------_----_-----------------------------___------------------------------------


# MIG:
  mig is created group of identical vm using single template
  majorly used for:autoscaling-autohealing-loadbalancing-rolling updates-multizone high avaibility
  auto-scaling: it scales based on cpu
    If CPU > 60% → Add 1 VM
    If CPU < 20% → Remove 1 VM
    How cpu increase:
     take the requets open html Backend code runs
     interect to databse to run query
     Page is generated
     API output is created
     Response is sent back
This scanario mutiple user hits problem 
   auto-healing: it actually done when vm un-healthy 
   vm unhelathy:script fail-app crashed-os freezed
   VM unhealthy for 5 mins → delete VM → create new VM automatically
Rolling-update: blue-green deployment based on max surge and max unaivable by maintain no deployment
     in mig used startup script takes 30-60 sec
     in k8s used in image tkes 1-2 sec actually no downtime
multi-zones: same region maintian multiple zones 
