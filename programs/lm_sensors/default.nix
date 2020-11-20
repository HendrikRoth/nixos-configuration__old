{ stdenv, pkgs, fetchzip, bison, flex, which, perl
, sensord ? false, rrdtool ? null
}:

assert sensord -> rrdtool != null;

stdenv.mkDerivation rec {
  pname = "lm-sensors";
  version = "git";
  #dashedVersion = stdenv.lib.replaceStrings ["."] ["-"] version;
  dashedVersion = "git";

  src = pkgs.fetchFromGitHub {
      owner = "lm-sensors";
      repo = "lm-sensors";
      rev = "5deee7d0c301df7790e028e4a5d891a70c406998";
      sha256 = "0hf8wzjlwycws6kaaw9palxhqjbgp5nn91zj60xk4pd0n0hspj3y";
   };

  nativeBuildInputs = [ bison flex which ];
  buildInputs = [ perl ]
   ++ stdenv.lib.optional sensord rrdtool;

  makeFlags = [
    "PREFIX=${placeholder "out"}"
    "ETCDIR=${placeholder "out"}/etc"
    "CC=${stdenv.cc.targetPrefix}cc"
    "AR=${stdenv.cc.targetPrefix}ar"
  ] ++ stdenv.lib.optional sensord "PROG_EXTRA=sensord";

  meta = with stdenv.lib; {
    homepage = "https://hwmon.wiki.kernel.org/lm_sensors";
    changelog = "https://raw.githubusercontent.com/lm-sensors/lm-sensors/V${dashedVersion}/CHANGES";
    description = "Tools for reading hardware sensors";
    license = with licenses; [ lgpl21Plus gpl2Plus ];
    platforms = platforms.linux;
  };
}
