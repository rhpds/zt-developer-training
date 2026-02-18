#!/bin/bash
USER=rhel

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "Setup vm vscode" > /tmp/progress.log

chmod 666 /tmp/progress.log 

# Install VSCode
mkdir -p /home/$USER/.local/share/code-server/User/
mkdir -p /home/$USER/.config/code-server/
cat >/home/$USER/.config/code-server/config.yaml << EOF
bind-addr: 0.0.0.0:9090
auth: none
cert: false
disable-update-check: true
EOF

cat >/home/$USER/.local/share/code-server/User/settings.json <<EOL
{
  "git.ignoreLegacyWarning": true,
  "window.menuBarVisibility": "visible",
  "git.enableSmartCommit": true,
  "workbench.tips.enabled": false,
  "workbench.startupEditor": "readme",
  "telemetry.enableTelemetry": false,
  "search.smartCase": true,
  "git.confirmSync": false,
  "workbench.colorTheme": "Visual Studio Dark",
  "update.showReleaseNotes": false,
  "update.mode": "none",
  "files.exclude": {
    "**/.*": true
  },
  "files.watcherExclude": {
    "**": true
  },
  "files.watcherExclude": {
    "**": true
  },
  "security.workspace.trust.enabled": false,
  "redhat.telemetry.enabled": false
}
EOL

chown $USER.$USER /home/$USER/.config/code-server/config.yaml /home/$USER/.local/share/code-server/User/settings.json
curl -fsSL https://code-server.dev/install.sh | sh
sudo systemctl enable --now code-server@$USER
