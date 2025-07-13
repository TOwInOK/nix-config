{ config, pkgs, ... }:

let
  whitelistFile = ./whitelist.txt;
in
{
  systemd.services.zapret = {
    enable = true;
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    path = with pkgs; [
      iptables
      nftables
      ipset
      curl
      gawk
      (zapret.overrideAttrs (_: {
        src = pkgs.fetchFromGitHub {
          owner = "bol-van";
          repo = "zapret";
          rev = "29c8aec1116d504692bebc16420d0e3ad65c030b";
          hash = "sha256-diWPEakHgYytBknng1Opfr7XZbf58JqzwPz8KbmNcBQ=";
        };
      }))
    ];

    serviceConfig = {
      Type = "forking";
      Restart = "no";
      TimeoutSec = "30sec";
      IgnoreSIGPIPE = "no";
      KillMode = "none";
      GuessMainPID = "no";

      ExecStart = "${pkgs.bash}/bin/bash -c 'zapret start'";
      ExecStop = "${pkgs.bash}/bin/bash -c 'zapret stop'";

      EnvironmentFile = pkgs.writeText "zapret-env" ''
        MODE="nfqws"
        FWTYPE="iptables"
        MODE_HTTP=1
        MODE_HTTP_KEEPALIVE=0
        MODE_HTTPS=1
        MODE_QUIC=1
          QUIC_PORTS=50000-65535
        MODE_FILTER=none
        DISABLE_IPV6=1
        INIT_APPLY_FW=1

        NFQWS_OPT_DESYNC="--dpi-desync=syndata,fake,split2 --dpi-desync-fooling=md5sig --dpi-desync-repeats=6"
        NFQWS_OPT_DESYNC_QUIC="--dpi-desync=fake,tamper --dpi-desync-any-protocol"

        # ← подключаем белый список
        WHITELIST="${whitelistFile}"
      '';
    };
  };

  # символическая ссылка в /etc, чтобы можно было легко править файл руками
  environment.etc."zapret/whitelist.txt".source = whitelistFile;
}
