#!/bin/bash

cd ~/CAD/_util/
openscad renderer.scad -D "f='../$ARGV'" -o renderer.png
cd -
