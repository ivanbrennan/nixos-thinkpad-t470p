{ buildPythonPackage
, isPy3k
, fetchurl
, jinja2
, pyyaml
, ansicolors
, boto
, html5lib
, hypchat
, kubernetes
, progressbar
, redis
, requests
, retrying
, semantic-version
, setuptools
, urllib3
, credstash
, marshmallow
}:

buildPythonPackage rec {
  name = "sumall-cli-0.8.7";

  disabled = isPy3k;

  src = fetchurl {
    url = "https://pypi-prod.sumall.net/packages/${name}.tar.gz";
    sha256 = "1nlb1smjawqqi6cd20i0kh62qxz8w3f778p5q83knb6a8z59yddf";
  };

  buildInputs = [
    jinja2
    pyyaml
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

  # argparse is part of the standardlib
  # prePatch = ''
  #   substituteAllInPlace setup.py --replace "argparse," ""
  #   substituteInPlace sumall/main.py --replace "import argparse" ""
  # '';

  doCheck = false;

  meta = {
    description = "SumAll command line utilities";
    homepage = https://github.com/SumAll/sumall-cli;
  };
}
