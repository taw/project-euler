#!/usr/bin/env ruby1.9

p (2..100).map{|a| (2..100).map{|b| a**b}}.flatten.uniq.size
