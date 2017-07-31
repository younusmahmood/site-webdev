# This bash file is meant to be source'd, not executed.

if [[ -z "$(type -t rvm)" ]]; then
    echo "ERROR: rvm not installed. See site-webdev README. Skipping setup."
elif [[ -z "$(type -t nvm)" ]]; then
    echo "ERROR: nvm not installed. See site-webdev README. Skipping setup."
elif [[ -z "$NGIO_ENV_DEFS" || "$1" == "--reset" ]]; then
    export NGIO_ENV_DEFS=1
    export ANSI_YELLOW="\033[33;1m"
    export ANSI_RESET="\033[0m"
    echo -e "${ANSI_YELLOW}Setting environment variables from scripts/env-set.sh${ANSI_RESET}"

    nvm use 6

    # Configure RVM so it doesn't complain if it isn't first in your PATH:
    RVMRC=~/.rvmrc
    RVM_SILENCE_PATH=rvm_silence_path_mismatch_check_flag
    if [[ ! -r $RVMRC ]] || ! grep -q $RVM_SILENCE_PATH $RVMRC;  then
        echo $RVM_SILENCE_PATH=1 >> $RVMRC
    fi
    rvm use 2.3
    
    : ${NGIO_REPO:=../angular.io}
    export NGIO_REPO
    : ${NG_REPO:=../angular}
    export NG_REPO
    : ${NGDOCEX:=examples/ng/doc}
    export NGDOCEX
    : ${ACX_REPO:=../angular_components}
    export ACX_REPO
    : ${CEU_REPO:=../code_excerpt_updater}
    export CEU_REPO

    # Git tag names
    export NG_RELEASE=4.0.0-alpha
    export NG_TEST_RELEASE=1.0.0-beta+4
    export ACX_RELEASE=v0.5.3+1

    if [ ! $(type -t travis_fold) ]; then
        # In case this is being run locally. Turn travis_fold into a noop.
        travis_fold () { true; }
    fi
    export -f travis_fold

    case "$(uname -a)" in
        Darwin\ *) _OS_NAME=macos ;;
        Linux\ *) _OS_NAME=linux ;;
        *) _OS_NAME=linux ;;
    esac
    export _OS_NAME

    : ${TMP:=$HOME/tmp}
    : ${PKG:=$TMP/pkg}
    export TMP
    export PKG

    if [[ -z "$(type -t dart)" && ! $PATH =~ \/dart-sdk ]]; then
        export DART_SDK="$PKG/dart-sdk"
        # Updating PATH to include access to Dart bin.
        export PATH="$PATH:$DART_SDK/bin"
        export PATH="$PATH:$HOME/.pub-cache/bin"
    fi

    if [[ -z "$(type -t content_shell)" && ! $PATH =~ \/content_shell ]]; then
        export PATH="$PATH:$PKG/content_shell"
    fi
fi
