# Terraform Functions — One-Line Real-World Examples

## 1. String Functions

1. `upper("dev") → "DEV"` — standardize environment names
2. `lower("PROD") → "prod"` — lowercase resource names
3. `title("azure devops") → "Azure Devops"` — format display text
4. `trim(" dev "," ") → "dev"` — remove extra spaces
5. `trimprefix("rg-prod","rg-") → "prod"` — clean Azure resource prefixes
6. `trimsuffix("app-dev","-dev") → "app"` — remove environment suffix
7. `trimspace(" test ") → "test"` — sanitize variable input
8. `replace("aks-dev","-","_") → "aks_dev"` — naming compliance
9. `split(",","web,api,db") → ["web","api","db"]` — parse app lists
10. `join("-",["prod","web"]) → "prod-web"` — build naming conventions
11. `substr("terraform",0,4) → "terr"` — shorten names
12. `strrev("abc") → "cba"` — reverse string
13. `startswith("aks-prod","aks") → true` — validate naming standard
14. `endswith("main.tf",".tf") → true` — check Terraform files
15. `strcontains("prod-app","prod") → true` — environment detection
16. `format("%s-%s","web","prod") → "web-prod"` — dynamic names
17. `formatlist("vm-%s",[1,2]) → ["vm-1","vm-2"]` — generate VM names
18. `regex("[0-9]+","app123") → "123"` — extract numbers
19. `regexall("[a-z]","a1b2") → ["a","b"]` — extract letters
20. `indent(2,"line")` — format YAML/JSON blocks
21. `chomp("hello\n") → "hello"` — remove newline

---

## 2. Numeric Functions

22. `abs(-5) → 5` — normalize negative values
23. `ceil(2.1) → 3` — round up scaling values
24. `floor(2.9) → 2` — round down capacity values
25. `max(2,5,8) → 8` — choose highest SKU limit
26. `min(2,5,8) → 2` — choose lowest threshold
27. `pow(2,3) → 8` — compute exponential scaling
28. `signum(-7) → -1` — detect positive/negative values
29. `parseint("100",10) → 100` — convert string to number
30. `log(100,10) → 2` — logarithmic calculations

---

## 3. Collection Functions

31. `length(["vm1","vm2"]) → 2` — count Azure resources
32. `contains(["dev","prod"],"prod") → true` — validate environment
33. `distinct(["dev","dev","prod"]) → ["dev","prod"]` — remove duplicates
34. `element(["a","b","c"],1) → "b"` — fetch indexed item
35. `index(["web","api"],"api") → 1` — find service position
36. `keys({env="dev",app="web"}) → ["app","env"]` — retrieve map keys
37. `values({env="dev",app="web"}) → ["web","dev"]` — retrieve map values
38. `lookup({dev="B1",prod="P2"},"prod") → "P2"` — environment-based SKU selection
39. `merge({env="dev"},{owner="ops"})` — combine Azure tags
40. `flatten([["web"],["api"]]) → ["web","api"]` — simplify nested lists
41. `concat(["web"],["db"]) → ["web","db"]` — combine app lists
42. `slice(["a","b","c"],0,2) → ["a","b"]` — subset extraction
43. `sort(["z","a"]) → ["a","z"]` — ordered outputs
44. `reverse(["a","b"]) → ["b","a"]` — reverse deployment order
45. `zipmap(["vm1"],["10.0.0.4"])` — map VM to IP
46. `matchkeys(["vm1"],["dev"],["dev"])` — filter matching environments
47. `setunion(["a"],["b"])` — combine unique sets
48. `setintersection(["a","b"],["b"]) → ["b"]` — common values
49. `setsubtract(["a","b"],["b"]) → ["a"]` — remove overlaps
50. `setproduct(["dev"],["web"])` — generate combinations
51. `chunklist(["a","b","c"],2)` — split workloads in batches
52. `compact(["web","","api"]) → ["web","api"]` — remove empty values
53. `one(["aks-prod"]) → "aks-prod"` — ensure single result
54. `transpose({a=["1","2"]})` — swap map/list orientation

---

## 4. Encoding / Decoding Functions

55. `jsonencode({env="dev"})` — generate Azure Policy JSON
56. `jsondecode("{\"env\":\"dev\"}")` — parse JSON config
57. `yamlencode({app="web"})` — generate Kubernetes YAML
58. `yamldecode("app: web")` — parse YAML manifests
59. `base64encode("secret")` — encode secrets
60. `base64decode("c2VjcmV0")` — decode secrets
61. `base64gzip("data")` — compress + encode templates
62. `textencodebase64("hello","UTF-8")` — encode text payloads
63. `textdecodebase64("aGVsbG8=","UTF-8") → "hello"` — decode payloads
64. `csvdecode("name,env")` — import CSV configuration

---

## 5. Date & Time Functions

65. `timestamp()` — deployment timestamps
66. `formatdate("YYYY-MM-DD",timestamp())` — readable audit logs
67. `timeadd(timestamp(),"24h")` — expiration calculations

---

## 6. Filesystem Functions

68. `file("script.sh")` — load deployment scripts
69. `templatefile("app.tpl",{env="prod"})` — dynamic configuration generation
70. `fileexists("main.tf") → true` — validate required files
71. `fileset(path.module,"*.tf")` — locate Terraform files
72. `filebase64("cert.pfx")` — encode certificates
73. `dirname("/app/main.tf") → "/app"` — extract folder path
74. `basename("/app/main.tf") → "main.tf"` — extract filename
75. `pathexpand("~/file")` — expand user directory paths
76. `abspath("main.tf")` — full file path resolution

---

## 7. Hash & Crypto Functions

77. `md5("data")` — checksum validation
78. `sha1("data")` — secure hashing
79. `sha256("data")` — integrity verification
80. `sha512("data")` — stronger hashing
81. `bcrypt("password")` — secure password hashing
82. `base64sha256("data")` — Kubernetes secret hashing
83. `uuid()` — unique resource IDs
84. `uuidv5("dns","example.com")` — deterministic UUID generation
85. `rsadecrypt("cipher","key")` — decrypt secure payloads

---

## 8. IP Network Functions

86. `cidrhost("10.0.1.0/24",5) → "10.0.1.5"` — assign static IP
87. `cidrnetmask("10.0.1.0/24") → "255.255.255.0"` — subnet mask lookup
88. `cidrsubnet("10.0.0.0/16",8,1) → "10.0.1.0/24"` — create Azure subnets
89. `cidrsubnets("10.0.0.0/16",8,8)` — generate multiple subnets

---

## 9. Type Conversion Functions

90. `tolist(["a","b"])` — convert set to list
91. `tomap({env="dev"})` — normalize maps
92. `toset(["a","a"]) → ["a"]` — unique values only
93. `tonumber("10") → 10` — numeric conversion
94. `tostring(100) → "100"` — string conversion
95. `try(var.name,"default")` — safe fallback handling
96. `can(regex("x","xyz")) → true` — validation checks
97. `type(var.tags)` — inspect variable type

---

## 10. Utility Functions

98. `coalesce("", "default") → "default"` — first non-empty value
99. `coalescelist([],["web"]) → ["web"]` — first non-empty list
100. `nonsensitive(var.secret)` — expose masked values safely
101. `sensitive("password")` — protect secret outputs



# Terraform Functions Cheat Sheet (Azure DevOps + Azure)

A practical quick-reference for real-world DevOps usage with Terraform.

---

# 🥇 Tier 1 — MUST KNOW (Daily Usage)

### 1. length()

`length(["vm1","vm2"]) → 2` — count Azure resources in loops

### 2. lookup()

`lookup({dev="B1",prod="P2"},"prod") → "P2"` — select SKU per environment

### 3. merge()

`merge({env="dev"},{owner="ops"}) → {env="dev",owner="ops"}` — combine tags

### 4. concat()

`concat(["web"],["db"]) → ["web","db"]` — combine lists

### 5. flatten()

`flatten([["web"],["api"]]) → ["web","api"]` — flatten module outputs

### 6. contains()

`contains(["dev","prod"],"prod") → true` — validate environment

### 7. split()

`split(",","web,api,db") → ["web","api","db"]` — parse input string

### 8. join()

`join("-",["prod","web"]) → "prod-web"` — build resource names

### 9. replace()

`replace("aks-dev","-","_") → "aks_dev"` — naming compliance

### 10. jsonencode()

`jsonencode({env="dev"}) → JSON string` — Azure policy / API payloads

### 11. templatefile()

`templatefile("app.tpl",{env="prod"}) → rendered config` — dynamic configs

### 12. file()

`file("script.sh") → content` — load deployment scripts

### 13. try()

`try(var.name,"default") → "default"` — safe fallback handling

### 14. can()

`can(regex("x","xyz")) → true` — safe validation checks

### 15. cidrsubnet()

`cidrsubnet("10.0.0.0/16",8,1) → "10.0.1.0/24"` — Azure subnet creation

---

# 🥈 Tier 2 — VERY IMPORTANT (Used in Modules)

### 16. distinct()

`distinct(["dev","dev","prod"]) → ["dev","prod"]` — remove duplicates

### 17. slice()

`slice(["a","b","c"],0,2) → ["a","b"]` — select subset

### 18. sort()

`sort(["z","a"]) → ["a","z"]` — order resources

### 19. keys()

`keys({env="dev",app="web"}) → ["app","env"]` — extract keys

### 20. values()

`values({env="dev",app="web"}) → ["web","dev"]` — extract values

### 21. format()

`format("vm-%s","01") → "vm-01"` — naming standard

### 22. substr()

`substr("terraform",0,4) → "terr"` — shorten names

### 23. timestamp()

`timestamp() → "2026-05-13T..."` — logging & auditing

### 24. yamlencode()

`yamlencode({app="web"}) → YAML string` — Kubernetes manifests

### 25. yamldecode()

`yamldecode("app: web") → object` — config parsing

---

# 🥉 Tier 3 — INTERMEDIATE (Advanced DevOps)

### 26. zipmap()

`zipmap(["vm1"],["10.0.0.4"]) → map` — VM to IP mapping

### 27. matchkeys()

`matchkeys(["vm1"],["dev"],["dev"]) → ["vm1"]` — filter resources

### 28. setunion()

`setunion(["a"],["b"]) → ["a","b"]` — combine sets

### 29. setintersection()

`setintersection(["a","b"],["b"]) → ["b"]` — common values

### 30. chunklist()

`chunklist(["a","b","c"],2) → [["a","b"],["c"]]` — batch workloads

### 31. compact()

`compact(["web","","api"]) → ["web","api"]` — remove empty values

### 32. one()

`one(["aks-prod"]) → "aks-prod"` — enforce single value

### 33. regex()

`regex("[0-9]+","vm123") → "123"` — extract numbers

### 34. regexall()

`regexall("[a-z]","a1b2") → ["a","b"]` — extract letters

---

# ☁️ Real Azure DevOps Architecture Example (Terraform Usage)

## Scenario: Deploy AKS + Networking + App Infrastructure

### Step 1 — Naming standard

`join("-",[var.env,"aks","cluster"]) → "dev-aks-cluster"`

### Step 2 — Subnet creation

`cidrsubnet("10.0.0.0/16",8,1) → "10.0.1.0/24"`

### Step 3 — Tags

`merge({env="dev"},{owner="platform"})`

### Step 4 — Select VM SKU

`lookup({dev="B2s",prod="D4s"},var.env)`

### Step 5 — Generate JSON policy

`jsonencode({allowedLocations=["westeurope"]})`

### Step 6 — Kubernetes config

`yamlencode({apiVersion="v1",kind="ConfigMap"})`

### Step 7 — Safe variables

`try(var.image_tag,"latest")`

---

# 🚀 How This Is Used in Real DevOps Pipelines

* YAML pipeline runs Terraform
* Terraform uses these functions for logic
* Azure resources are generated dynamically
* Naming, networking, and policies are automated

---

# 💡 Key Insight

If you master Tier 1 functions:
✔ You can build real Azure infrastructure
✔ You can write production Terraform modules
✔ You can pass DevOps interviews
✔ You understand 80% of real-world usage

