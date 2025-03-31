local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    colors.bg_line = util.blend_bg(colors.bg_highlight, 0.1)
    local lazygit = util.template(
        [[---
gui:
  scrollHeight: 2
  language: "auto"
  border: "hidden"
  theme:
    activeBorderColor:
      - "${orange}"
      - "bold"
    inactiveBorderColor:
      - "${border_highlight}"
    selectedLineBgColor:
      - "${bg_line}"
    optionsTextColor:
      - "${blue}"
  returnImmediately: false
  wrapMainPanel: true
  sidePanelWidth: 0.333
  showBottomLine: true
  expandFocusedSidePanel: false
  screenMode: "normal"
  containerStatusHealthStyle: "long"
logs:
  timestamps: false
  since: '60m'
  tail: ''
commandTemplates:
  dockerCompose: docker compose # Determines the Docker Compose command to run, referred to as .DockerCompose in commandTemplates
  restartService: '{{ .DockerCompose }} restart {{ .Service.Name }}'
  up:  '{{ .DockerCompose }} up -d'
  down: '{{ .DockerCompose }} down'
  downWithVolumes: '{{ .DockerCompose }} down --volumes'
  upService:  '{{ .DockerCompose }} up -d {{ .Service.Name }}'
  startService: '{{ .DockerCompose }} start {{ .Service.Name }}'
  stopService: '{{ .DockerCompose }} stop {{ .Service.Name }}'
  serviceLogs: '{{ .DockerCompose }} logs --since=60m --follow {{ .Service.Name }}'
  viewServiceLogs: '{{ .DockerCompose }} logs --follow {{ .Service.Name }}'
  rebuildService: '{{ .DockerCompose }} up -d --build {{ .Service.Name }}'
  recreateService: '{{ .DockerCompose }} up -d --force-recreate {{ .Service.Name }}'
  allLogs: '{{ .DockerCompose }} logs --tail=300 --follow'
  viewAlLogs: '{{ .DockerCompose }} logs'
  dockerComposeConfig: '{{ .DockerCompose }} config'
  checkDockerComposeConfig: '{{ .DockerCompose }} config --quiet'
  serviceTop: '{{ .DockerCompose }} top {{ .Service.Name }}'
oS:
  openCommand: open {{filename}}
  openLinkCommand: open {{link}}
stats:
  graphs:
    - caption: CPU (%)
      statPath: DerivedStats.CPUPercentage
      color: blue
    - caption: Memory (%)
      statPath: DerivedStats.MemoryPercentage
      color: green]],
        colors
    )
    return lazygit
end

return M
