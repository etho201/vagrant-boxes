# Host re-registration

## Prevent duplicate entries when re-registering servers

Create a script called `olmreg.sh`
```bash
if [[ $(rhnreg_ks --sslCACert=/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT --serverUrl=http://192.168.56.10/XMLRPC --activationkey=1-oraclelinux7-x86_64) == "This system is already registered. Use --force to override" ]]; then
    spacecmd -- clear_caches
    SYSTEMID=$(spacecmd -- system_search $(hostname))
    spacecmd -- system_delete $SYSTEMID
fi

rhnreg_ks --sslCACert=/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT --serverUrl=http://192.168.56.10/XMLRPC --activationkey=$1 --force
```

Then run:

```
./olmreg.sh 1-oraclelinux7-x86_64
```
> Where `1-oraclelinux7-x86_64` is the activation key you want to use.
---

This method requires the user to have `spacecmd` installed on all client systems, and it also requires the OLM password.

If I were the administrator, I would probably run a FastAPI service on the OLM server, and have systems call out to that API (this way I would not have to require the user to install spacecmd, nor would I need to expose the OLM username and password to the user)… In that scenario, the systems could be registered via a simple curl command that would hit the FastAPI endpoint, and I would use FastAPI to execute the registration/re-registration of the server.

---

# FastAPI

```bash
dnf install -y python3
pip3 install fastapi uvicorn
```

> `pip3 install "fastapi[all]"` includes uvicorn


