{ config, pkgs, ... }:

let
  whitelistFile = ./whitelist.txt;
  zap = zapret.overrideAttrs (_: {
    src = pkgs.fetchFromGitHub {
      owner = "bol-van";
      repo  = "zapret";
      rev   = "29c8aec1116d504692bebc16420d0e3ad65c030b";
      hash  = "sha256-diWPEakHgYytBknng1Opfr7XZbf58JqzwPz8KbmNcBQ=";
    };
  });

  binDir  = "${zap}/bin";
  listDir = "${zap}/list";
  quicBin = "${binDir}/quic_initial_www_google_com.bin";
  tlsBin  = "${binDir}/tls_clienthello_www_google_com.bin";

  envFile = pkgs.writeText "zapret-env" ''
    MODE="nfqws"
    FWTYPE="iptables"
    DISABLE_IPV6=1
    HF_WF_TCP="80,443"
    HF_WF_UDP="443,50000-65535"

    # Основные фильтры
    FILTER_L7="discord,stun"
    FILTER_UDP="443"
    FILTER_TCP="80,443"

    # DPI desync
    DPI_DESYNC="fake"
    DPI_REPEAT="6"
    DPI_SPLIT2="split2"
    DPI_AUTOTTL="2"
    DPI_MD5SIG="md5sig"

    # Указатели на бинарники
    QUIC_BIN="${quicBin}"
    TLS_BIN="${tlsBin}"

    HOSTLIST="${listDir}/list-general.txt"
    IPSET="${listDir}/ipset-cloudflare.txt"
    WHITELIST="${whitelistFile}"
  '';
in {
  # Сервис zapret
  systemd.services.zapret = {
    enable    = true;
    after     = [ "network-online.target" ];
    wants     = [ "network-online.target" ];
    wantedBy  = [ "multi-user.target" ];

    path = with pkgs; [ bash iptables nftables ipset curl gawk zap ];

    serviceConfig = {
      Type        = "simple";
      Restart     = "on-failure";
      TimeoutSec  = "30s";
      IgnoreSIGPIPE = "no";
      KillMode    = "none";
      GuessMainPID = "no";

      ExecStart = ''
        ${zap}/bin/zapret \
          --wf-tcp="$${HF_WF_TCP}" \
          --wf-udp="$${HF_WF_UDP}" \
          --filter-l7="$${FILTER_L7}" \
          --filter-udp="$${FILTER_UDP}" \
          --filter-tcp="$${FILTER_TCP}" \
          --dpi-desync="$${DPI_DESYNC},$${DPI_SPLIT2}" \
          --dpi-desync-repeats="$${DPI_REPEAT}" \
          --dpi-desync-autottl="$${DPI_AUTOTTL}" \
          --dpi-desync-fooling="$${DPI_MD5SIG}" \
          --dpi-desync-fake-quic="$${QUIC_BIN}" \
          --dpi-desync-fake-tls="$${TLS_BIN}" \
          --ipset="$${IPSET}" \
          --hostlist="$${HOSTLIST}" \
          --whitelist="$${WHITELIST}" \
          --mode="$${MODE}" \
          --fwtype="$${FWTYPE}"
      '';

      ExecStop = "${pkgs.bash}/bin/bash -c '${zap}/bin/zapret stop'}";

      EnvironmentFile = envFile;
    };
  };

  # Ссылка на whitelist.txt
  environment.etc."zapret/whitelist.txt".source = whitelistFile;
}
