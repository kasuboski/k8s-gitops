# Cloudflare tunnel to the ingress

## Setup
`cloudflared tunnel create home-external-ingress`

`cloudflared tunnel route dns home-external-ingress cloud.joshcorp.co`

The config routes *.joshcorp.co to ingress-nginx. It needs to accept the fake cert nginx has.

