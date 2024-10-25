{ config, options, lib, pkgs, my, ... }:

{
  environment.systemPackages = with pkgs; [
    # python312
    # python312Packages.pip
    # python312Packages.ipython
    # python312Packages.black
    # python312Packages.setuptools
    # python312Packages.virtualenv
    # python312Packages.pylint
  ];

  environment.variables = {
    # IPYTHONDIR      = "$XDG_CONFIG_HOME/ipython";
    # PIP_CONFIG_FILE = "$XDG_CONFIG_HOME/pip/pip.conf";
    # PIP_LOG_FILE    = "$XDG_DATA_HOME/pip/log";
    # PYLINTHOME      = "$XDG_DATA_HOME/pylint";
    # PYLINTRC        = "$XDG_CONFIG_HOME/pylint/pylintrc";
    # PYTHONSTARTUP   = "$XDG_CONFIG_HOME/python/pythonrc";
    # PYTHON_EGG_CACHE = "$XDG_CACHE_HOME/python-eggs";
    # JUPYTER_CONFIG_DIR = "$XDG_CONFIG_HOME/jupyter";
  };

  environment.shellAliases = {
    # py     = "python";
    # py3    = "python3";
    # ipy    = "ipython --no-banner";
    # ipylab = "ipython --pylab=qt5 --no-banner";
  };
}