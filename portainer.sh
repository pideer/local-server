docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# with traefik reverse proxy

docker run -d -p 9000:9000 -p 9443:9443 \
  --name portainer \
  --network docker \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  --label "traefik.enable=true" \
  --label "traefik.http.routers.portainer.rule=Host(\`portainer.server.local\`)" \
  --label "traefik.http.services.portainer.loadbalancer.server.port=9000" \
  --label "traefik.http.routers.portainer.entrypoints=websecure" \
  --label "traefik.http.routers.portainer.tls=true" \
  portainer/portainer-ce:latest 
