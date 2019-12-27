# frozen_string_literal: true

require 'shellwords'

SCAD = FileList['**/*.scad'].exclude do |f|
  # File.mtime(f) < Time.now - 60*60*24*7
  false
end.exclude do |f|
  rootdir = File.dirname(f)[%r{^[^/]*}]
  File.exist?("#{rootdir}/assemblies") && File.exist?("#{rootdir}/vitamins")
end
LSTL  = SCAD.ext 'stl'
L3MF  = SCAD.ext '3mf'


def ffix(fff, ext)
  "#{File.dirname(fff)}/#{File.basename(fff, '.*')}.#{ext}"
end

def echo(s)
  sh "echo #{s}"
end


task default: :build
task :build => :stl

task :all => [:stl, :"3mf"]


desc 'Build 3mf files from scad files'
multitask :"3mf" => L3MF do
  echo 'Build done'
end

rule '.3mf' => '.scad' do |f|
  sh "openscad #{Shellwords.escape(f.source)} -o #{Shellwords.escape(f.name)}"
end


desc 'Build stl files from scad files'
multitask :stl => LSTL do
  echo 'Build done'
end

rule '.stl' => '.scad' do |f|
  sh "openscad #{Shellwords.escape(f.source)} -o #{Shellwords.escape(f.name)}"
end

# LSTL.each do |ff|
#   desc "#{ff} -> #{ffix(ff, 'scad')}"
#   task ff => ffix(ff, 'scad') do
#     echo "openscad #{ffix(ff, 'scad')} -o #{ff}"
#   end
#   task :build => ff
# end
