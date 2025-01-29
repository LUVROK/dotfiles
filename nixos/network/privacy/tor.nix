{ config, lib, pkgs, ... }:

{
  services.tor = {
    enable = true;
    # openFirewall = true;

    client = {
      enable = true;
      # dns.enable = true;
      # socksListenAddress = {
      #   IsolateDestAddr = true;
      #   addr = "0.0.0.0";
      #   port = 9060;
      # };
    };

    settings = {
      # SocksPort = [ "9060" ];
      UseBridges = true;
      ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/lyrebird";
      Bridge = "obfs4 79.117.21.113:8080 B646D7A89BD9F8128A3AED440B4A1168ED505F65 cert=HVQbUpOskR1NmkaciXRY3XsiPuodTfowGgdR+/8HfKanu/l1wKAsOj20Fx+lsidT/w2vUw iat-mode=0";
      
      # Bridge = [
      #   "obfs4 79.117.21.113:8080 B646D7A89BD9F8128A3AED440B4A1168ED505F65 cert=HVQbUpOskR1NmkaciXRY3XsiPuodTfowGgdR+/8HfKanu/l1wKAsOj20Fx+lsidT/w2vUw iat-mode=0"
      #   "obfs4 109.235.37.47:8443 CC3D4004181ACADE02AA19229777153F8C685684 cert=hbfGbCsbMFuZbTllS4H3JkOaXBpNNlA2Z32+hgy7JZum9DRAPAdZFZxIikof5qhu6SdyYw iat-mode=0"
      #   "obfs4 15.235.47.71:58131 7AAC6E36700ECB0B9869BC70B7397D3A158EDE3E cert=QkNiC9DVrXqcyn1Y6njSwiNsOGGBb1anPVpE6Mjdph9jxr0Wi0fk9LArNCdvO4kCIIRdIA iat-mode=0"
      #   "obfs4 37.59.24.55:47986 B48D31E6EE548E06651F478F6F31C826D965FB62 cert=1tDFcnBwTS9kCEVAQKm4ub9KPPrqIivK7VtvoCnPnL+HdLj6UE+O/2mY9bY0edaac+QrGw iat-mode=0"
      # ];
    };
  };

  environment.systemPackages = with pkgs; [
    obfs4
    tor
    torsocks
    tor-browser
  ];
}