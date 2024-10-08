#!/bin/sh

# Upstream PR: https://github.com/github/cmark-gfm/pull/362
patch -p2 -d ../cmark < 362.diff

