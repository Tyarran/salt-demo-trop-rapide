PG server installed:
    pkg.installed:
        - name: postgresql

PG Server UP:
    service.running:
        - name: postgresql
        - enable: True
        - require:
            - pkg: PG server installed

