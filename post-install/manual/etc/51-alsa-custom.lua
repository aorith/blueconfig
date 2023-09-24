alsa_monitor.enabled = true

alsa_monitor.properties = {
  ["alsa.reserve"] = true,
  ["alsa.reserve.application-name"] = "WirePlumber",
  ["alsa.midi"] = true,
  ["alsa.midi.monitoring"] = true,
  ["alsa.midi.node-properties"] = {
    ["node.name"] = "Midi-Bridge",
    ["api.alsa.disable-longname"] = true,
  },
}

alsa_monitor.rules = {
  {
    matches = {
      {
        -- This matches all cards.
        { "device.name", "matches", "alsa_card.*" },
      },
    },
    apply_properties = {
      ["api.alsa.use-acp"] = true,
      ["api.acp.auto-profile"] = false,
      ["api.acp.auto-port"] = false,
    },
  },
  {
    matches = {
      {
        -- Matches all sinks.
        { "node.name", "matches", "alsa_output.pci-0000_0b_00.1.hdmi-stereo-extra3" },
      },
    },
    apply_properties = {
      ["session.suspend-timeout-seconds"] = 0,
    },
  },
}
