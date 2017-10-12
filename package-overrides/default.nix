pkgs: {
  sumall_cli = pkgs.callPackage ../custom-packages/sumall_cli {
    inherit (pkgs) fetchurl kubernetes;
    inherit (pkgs.pythonPackages) buildPythonPackage isPy3k jinja2 pyyaml ansicolors boto html5lib hypchat progressbar redis requests retrying semantic-version setuptools urllib3 credstash marshmallow;
  };
}
