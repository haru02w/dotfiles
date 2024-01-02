{ python3Packages }:
with python3Packages;
buildPythonApplication rec{
  pname = "main";
  version = "1.0";
  src = ./src;

  propagatedBuildInputs = [ matplotlib ];
  postInstall = ''
    mv -v $out/bin/${pname}.py $out/bin/${pname}
  '';
}
