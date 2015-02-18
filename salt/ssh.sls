SSH Access Packages:
    pkg.installed:
        - pkgs:
            - openssh-server
            - jp2a
            - figlet
            - sudo

{% for user in pillar['users'] %}
Create {{ user['username'] }} user:
    user.present:
        - name: {{ user['username'] }}
        - fullname: {{ user['fullname'] }}
        - shell: /bin/bash
        - home: /home/{{ user['username'] }}
        - password: {{ user['password'] }}
        - groups:
            - sudo
{% endfor %}

Login message:
    file.managed:
        - name: /etc/profile.d/logo.jpg
        - source: salt://files/logo.jpg
        - user: root
        - group: root
        - mode: 644

Global env profile:
    file.managed:
        - name: /etc/profile.d/10-logo.sh
        - source: salt://files/profile
        - template: jinja
        - user: root
        - group: root
        - mode: 644


Service SSH service:
    service.running:
        - name: ssh
        - enable: True
        - reload: True
        - require:
            - pkg: SSH Access Packages
            {% for user in pillar['users'] %}
            - user: Create {{ user['username'] }} user
            {% endfor %}
            - file: Global env profile
