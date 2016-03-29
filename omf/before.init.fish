# Host specific
switch (hostname -s)
  case jamehi03lx noardestls01
    set proxy_auth true
    set proxy_host proxysg.noa.com:8080
    set proxy_user jamehi03
end
