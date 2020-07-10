echo PATH = $PATH
echo vessel @ `which vessel`

echo
echo == Build.
echo

dfx start --background
dfx canister create --all
dfx build

echo
echo == Test.
echo

dfx canister install --all
dfx canister call superheroes create '(record {name = "Superman"; superpowers = opt record { 0 = "invulnerability"; 1 = opt record { 0 = "superhuman strength"; 1 = null; }; }; })'
dfx canister call superheroes read '(0)'
dfx canister call superheroes update '(0, record {name = "Superman"; superpowers = opt record { 0 = "invulnerability"; 1 = opt record { 0 = "superhuman strength"; 1 = opt record { 0 = "flight"; 1 = opt record { 0 = "x-ray vision"; 1 = null; }; }; }; }; })'
dfx canister call superheroes delete '(0)'
dfx canister call www retrieve '("index.js")'
