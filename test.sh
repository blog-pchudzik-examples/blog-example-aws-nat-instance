#!/usr/bin/env bash

function test() {
    for template in *.template.yml; do
        aws cloudformation validate-template --template-body file://${template} 1> /dev/null
        if [ $? != 0 ]; then
            echo "ERROR: $template"
            exit 1
        else
            echo "OK: $template"
        fi
    done;
}

test
