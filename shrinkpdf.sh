#!/bin/env bash
[ ! -z ${1} ] && [ ! -z ${2} ] && gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -dColorImageResolution=150 -sOutputFile="${2}" "${1}" || echo "provide both input and output" && exit 1
