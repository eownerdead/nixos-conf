{stdenv, fetchFromGitHub}:
stdenv.mkDerivation {
    name = "gittyup";

    buildInput = [  ];

    src = fetchFromGitHub {
        owner = "Murmele";
        repo = "Gittyup";
        rev = "d52896fa79c596bed4d662633f48c507496c9fd6";
    };
}
