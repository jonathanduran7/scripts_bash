#!/bin/bash

current_branch=$(git rev-parse --abbrev-ref HEAD)

git push origin $current_branch
