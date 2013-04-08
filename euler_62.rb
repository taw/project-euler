#!/usr/bin/env ruby1.9

cubes = {}

(1..10_000).each{|i|
  key = (i**3).to_s.split(//).sort.join
  (cubes[key] ||= []) << i
}

cubes.each{|k, cubes|
  next unless cubes.size >= 5
  p [k, cubes, cubes.map{|i| i**3}]
}
