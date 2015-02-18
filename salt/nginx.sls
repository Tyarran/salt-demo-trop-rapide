Nginx HTTP installed:
    pkg.installed:
        - name: nginx


NGINX Server UP:
    service.running:
        - name: nginx
        - enable: True
        - require:
            - pkg: Nginx HTTP installed
