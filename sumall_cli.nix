{ stdenv, fetchurl, pythonPackages }:

with stdenv.lib;

pythonPackages.buildPythonPackage rec {
  name = "sumall-cli-0.8.7";

  src = fetchurl {
    url = "https://pypi-prod.sumall.net/packages/${name}.tar.gz";
    sha256 = "1nlb1smjawqqi6cd20i0kh62qxz8w3f778p5q83knb6a8z59yddf";
  };

  buildInputs = with self; [
    Jinja2
    PyYAML
    ansicolors
    boto
    html5lib
    hypchat
    kubernetes
    progressbar
    redis
    requests
    retrying
    semantic-version
    setuptools
    urllib3
    credstash
    marshmallow
  ];

  doCheck = true;

  meta = {
    description = "SumAll command line utilities";
    homepage = https://github.com/SumAll/sumall-cli;
  };
}
