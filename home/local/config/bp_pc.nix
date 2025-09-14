{ config, ... }:

{
  # nekoray bypass
  home.file.".config/nekoray/config/route_profiles/bp_pc.json".text = ''
    {
        "default_outbound": -1,
        "id": bp_pc,
        "name": "Bypass Russia",
        "rules": [
            {
                "actionType": "hijack-dns",
                "invert": false,
                "ip_is_private": false,
                "ip_version": "",
                "name": "dns-hijack",
                "network": "",
                "noDrop": false,
                "outboundID": -2,
                "override_address": "",
                "override_port": 0,
                "protocol": "dns",
                "rejectMethod": "",
                "simple_action": 0,
                "sniffOverrideDest": false,
                "source_ip_is_private": false,
                "strategy": "",
                "type": 0
            },
            {
                "actionType": "route",
                "domain_regex": [
                    ".*46.8.238.132.*",
                    ".*twenty5443\\.duckdns\\.org.*"
                ],
                "invert": false,
                "ip_is_private": false,
                "ip_version": "",
                "name": "Simple Address -> direct",
                "network": "",
                "noDrop": false,
                "outboundID": -2,
                "override_address": "",
                "override_port": 0,
                "protocol": "",
                "rejectMethod": "",
                "rule_set": [
                    "ru_IP",
                    "category-ru_SITE"
                ],
                "simple_action": 0,
                "sniffOverrideDest": false,
                "source_ip_is_private": false,
                "strategy": "",
                "type": 1
            },
            {
                "actionType": "reject",
                "invert": false,
                "ip_is_private": false,
                "ip_version": "",
                "name": "Simple Address -> block",
                "network": "",
                "noDrop": false,
                "outboundID": -2,
                "override_address": "",
                "override_port": 0,
                "protocol": "",
                "rejectMethod": "",
                "rule_set": [
                    "category-ads-all_SITE"
                ],
                "simple_action": 1,
                "sniffOverrideDest": false,
                "source_ip_is_private": false,
                "strategy": "",
                "type": 1
            },
            {
                "actionType": "route",
                "invert": false,
                "ip_is_private": false,
                "ip_version": "",
                "name": "Simple Process Name -> proxy",
                "network": "",
                "noDrop": false,
                "outboundID": -1,
                "override_address": "",
                "override_port": 0,
                "process_name": [
                    "zen-bin",
                    "chrome",
                    "firefox",
                    "vesktop.bin",
                    "spotify",
                    "Discord"
                ],
                "protocol": "",
                "rejectMethod": "",
                "simple_action": 2,
                "sniffOverrideDest": false,
                "source_ip_is_private": false,
                "strategy": "",
                "type": 2
            }
        ]
    }
  ''; 
}