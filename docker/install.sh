#! /bin/bash

FORCE=0
# parse the options
while getopts ':fh-:' opt ; do
    case $opt in
        -)
            case "${OPTARG}" in
                force)
                    FORCE=1 ;;
            esac;;
        f)
            FORCE=1
            echo "warning: forced installation"
            ;;
        h)
            echo "usage: $0 [-h] [--force]" >&2
            exit 2
            ;;
        *)
            echo "Invalid argument: '-${OPTARG}'" >&2
            echo "usage: $0 [-h] [--force]" >&2
            exit 2
            ;;
    esac
done

if [ -f /home/invenio/multivio/bin/activate ] && [ $FORCE == 0 ]; then
    echo "Already installed!"
    source multivio/bin/activate
else
    # create virtualenv if does not exists
    if [ ! -f /home/invenio/multivio/bin/activate ]; then
        virtualenv multivio
    fi

    # activate virtualenv
    source multivio/bin/activate

    # install nodejs tools done in the image
    # npm install -g --prefix ${VIRTUAL_ENV} npm
    # npm install -g --prefix ${VIRTUAL_ENV} r node-sass clean-css clean-css-cli requirejs uglify-js

    # clone the sources if does not exists
    mkdir -p multivio/src
    cd multivio/src

    if [ ! -f invenio-multivio ]; then
        git clone https://github.com/rero/invenio-multivio.git
    fi

    # install the invenio application
    cd invenio-multivio
    pip install -r requirements-devel.txt
    pip install -e .[all]
    pip install pillow-simd
    pip install cython

    # collect and install js dependencies
    invenio npm
    cd /home/invenio/multivio/var/instance/static
    npm install

    # collect static files
    invenio collect -v

    # test the assets
    invenio assets build
    echo "Installation done!"
fi
